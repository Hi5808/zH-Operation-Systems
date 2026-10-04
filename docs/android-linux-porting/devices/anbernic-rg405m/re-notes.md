# RE Notes: Anbernic RG405M

Stub — fill in as components are reverse engineered, per
[02-reverse-engineering-ghidra.md](../../02-reverse-engineering-ghidra.md).
Never commit the actual vendor binaries here — only derived notes
(register tables, init sequences, SMC call IDs, etc).

Given the existing GammaOS prior art (see [profile.md](profile.md)),
start by diffing stock firmware drivers against GammaOS's open kernel
source rather than disassembling from zero — most entries here should
end up being "confirmed identical to GammaOS's `<path>`" rather than a
fresh register-table recovery.

Suggested structure per component once work starts:

```markdown
## <component name>
- File: vendor/lib/modules/<name>.ko (stock) vs. GammaOS kernel path
- Diff result: [identical / minor differences / needs full RE]
- Notes:
```

No entries yet — firmware has not been dumped (see
[profile.md](profile.md) §1).
