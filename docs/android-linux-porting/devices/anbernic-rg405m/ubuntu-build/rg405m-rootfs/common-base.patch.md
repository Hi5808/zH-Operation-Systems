# Required one-line tweak to rootfs-builder-debos

`ubuntu-touch/common-base.yaml` hardcodes the base version. Make it overridable
so one recipe can target 24.04 and 26.04:

```diff
-{{- $ubuntu_base_version := "26.04" -}}
-{{- $ut_aptly_archive := "26.04-1.x" -}}
+{{- $ubuntu_base_version := or .ubuntu_base_version "26.04" -}}
+{{- $ut_aptly_archive := or .ut_aptly_archive "26.04-1.x" -}}
```
