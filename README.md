# Operation-Systems

A database of custom operating systems — each entry documents hardware targets, kernel config, software stack, and design decisions before any compilation or storage is used.

## Structure

```
os/
└── <os-name>/
    ├── spec.json   — machine-readable hardware + OS specification
    └── README.md   — human-readable overview and design notes
registry.json       — index of all OS entries
```

## OS Entries

| Name | Base | Target Hardware | Status |
|------|------|-----------------|--------|
| [SMBrix](os/smbrix/README.md) | TBD | HP Chromebook 14-SMB | Planning |
