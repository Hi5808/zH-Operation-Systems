# Contributing

Thanks for helping. The full conventions live with the guide:
**[docs/android-linux-porting/CONTRIBUTING.md](docs/android-linux-porting/CONTRIBUTING.md)**.
The essentials:

1. **Notes, not binaries.** Never commit vendor firmware or anything
   derived from it (`.img`, raw `kernel`/`ramdisk`/`.dtb`, HAL `.so`,
   vendor `.ko`, firmware blobs). Commit the *understanding* — device
   trees as source, kernel configs, checksummed manifests, RE notes,
   patches. `git status` before every commit; `.gitignore` is a backstop,
   not a guarantee.
2. **Don't state what you haven't verified.** Mark claims "unverified" or
   "confirm on device" rather than inventing a confident answer.
3. **Run the checker before a PR:**
   ```bash
   ./docs/android-linux-porting/scripts/check-docs.sh
   ```
   CI runs the same thing; a green local run means a green PR.
4. **Credit the prior work you build on** — a kernel tree, a tool, another
   project's device port. Name it and link it.

Adding a device? Scaffold it:
`./docs/android-linux-porting/scripts/new-device.sh CODENAME "Display Name" VENDOR MODEL`

By contributing you agree your work is licensed under the repository's
[MIT License](LICENSE).
