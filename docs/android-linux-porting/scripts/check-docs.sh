#!/usr/bin/env bash
# Validate the guide's internal consistency. Run from anywhere; it
# locates the guide root relative to itself. Exits non-zero on any
# problem, so CI can gate on it.
#
# Checks:
#   1. Every relative markdown link resolves to a file that exists.
#   2. Every chapter referenced in 00-overview.md's index exists.
#   3. Every script passes `bash -n`, and shellcheck if installed.
#   4. Every ```bash fenced block in the docs passes `bash -n`.

set -uo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GUIDE_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

fail=0

python3 - "$GUIDE_DIR" <<'PY' || fail=1
import os, re, glob, subprocess, sys
root = sys.argv[1]
os.chdir(root)
problems = []

# 1. Relative markdown links
link_re = re.compile(r'\]\(([^)]+)\)')
for f in glob.glob("**/*.md", recursive=True):
    for m in link_re.findall(open(f).read()):
        if m.startswith(("http://","https://","mailto:","#")):
            continue
        target = m.split("#", 1)[0]
        if not target:
            continue
        if not os.path.exists(os.path.join(os.path.dirname(f), target)):
            problems.append(f"broken link in {f} -> {m}")

# 2. Indexed chapters exist
overview = open("00-overview.md").read()
for ch in sorted(set(re.findall(r'\((\d{2}-[a-z-]+\.md)\)', overview))):
    if not os.path.exists(ch):
        problems.append(f"00-overview.md indexes missing chapter {ch}")

# 4. Fenced bash blocks parse
for f in glob.glob("*.md") + glob.glob("devices/*/*.md"):
    for i, b in enumerate(re.findall(r"```bash\n(.*?)```", open(f).read(), re.S)):
        r = subprocess.run(["bash","-n"], input=b, text=True, capture_output=True)
        if r.returncode != 0:
            problems.append(f"bash block {i} in {f}: {r.stderr.strip()}")

# 5. Every scripts/<name>.sh referenced in the docs exists on disk
on_disk = {os.path.basename(p) for p in glob.glob("scripts/*.sh")}
doc_text = "".join(open(f).read() for f in
                   glob.glob("*.md") + glob.glob("devices/*/*.md") + ["HANDOFF.md"]
                   if os.path.exists(f))
for ref in sorted(set(re.findall(r'scripts/([a-z-]+\.sh)', doc_text))):
    if ref not in on_disk:
        problems.append(f"docs reference scripts/{ref} but it does not exist")

for p in problems:
    print("FAIL:", p)
print(f"{'OK' if not problems else 'FAILED'}: links, index, and fenced bash blocks")
sys.exit(1 if problems else 0)
PY

# 3. Scripts
for s in "$GUIDE_DIR"/scripts/*.sh; do
  bash -n "$s" || { echo "FAIL: bash -n $s"; fail=1; }
done
if command -v shellcheck >/dev/null 2>&1; then
  shellcheck -S warning "$GUIDE_DIR"/scripts/*.sh || { echo "FAIL: shellcheck"; fail=1; }
else
  echo "note: shellcheck not installed; skipped"
fi

echo
[ "$fail" -eq 0 ] && echo "ALL CHECKS PASSED" || echo "CHECKS FAILED"
exit "$fail"
