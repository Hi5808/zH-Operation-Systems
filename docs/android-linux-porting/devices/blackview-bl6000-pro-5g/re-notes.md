# RE Notes: Blackview BL6000 Pro 5G

Stub — fill in as components are reverse engineered, per
[02-reverse-engineering-ghidra.md](../../02-reverse-engineering-ghidra.md).
Never commit the actual vendor binaries here — only derived notes
(register tables, init sequences, SMC call IDs, etc).

Suggested structure per component once work starts:

```markdown
## <component name, e.g. "Touchscreen (ILITEK? TBD)">
- File: vendor/lib/modules/<name>.ko
- Why RE'd: no public source found at <where you checked>
- Ghidra project: <local path, not committed>
- Recovered init sequence:
  | Register | Value | Delay |
  |---|---|---|
  | ... | ... | ... |
- Notes:
```

No entries yet — firmware has not been dumped (see
[profile.md](profile.md) §1).
