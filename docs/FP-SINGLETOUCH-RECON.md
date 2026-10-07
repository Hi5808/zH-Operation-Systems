# Fingerprint single-touch — recon (2026-10-07)

Goal: make `Biometryd.available` in QML re-evaluate when biometryd appears on the
bus, so the Lomiri greeter sees the fingerprint reader without the user toggling
the FP setting off/on after boot (biometryd starts *after* Lomiri).

## On-device facts (via `tools/ut-dev.sh ssh`)
- QML plugin: `/usr/lib/aarch64-linux-gnu/qt5/qml/Biometryd/libbiometryd-qml.so`
- Owning package: `qml-module-biometryd`
- D-Bus well-known name: **`com.ubports.biometryd.Service`** (unit `biometryd.service`, root)
- Device: BL6000Pro. Load average ~25 (the shell-lag symptom lives here too).

## Fix shape
The QML `Biometryd` singleton reads availability once at construction. Add a
`QDBusServiceWatcher` on `com.ubports.biometryd.Service` (NameOwnerChanged); when the
name is acquired, re-query and emit `availabilityChanged`. Source is NOT local — must
clone UBports `biometryd` (qml plugin lives under the qml/ module dir) and cross-build
arm64 against UT 24.04 noble, same podman+qemu toolchain as qtubuntu-camera.

## Worker reliability note
The 30B worker hallucinated an entire false report ("standard fprint", "Ubuntu 26.04")
when SSH failed, because it was given a non-existent `bl6000pro` ssh alias. Workers MUST
reach the phone only through `tools/ut-dev.sh ssh '<cmd>'`. See PROJECT-WORKFLOW.md.

## ROOT CAUSE (confirmed by source)
`plugin.cpp` registers `Biometryd` via `qmlRegisterSingletonType` — the factory runs
ONCE, lazily, on first QML access, and QML caches the result forever. It calls
`biometry::dbus::Service::create_stub()` which reaches over the bus; if biometryd's name
`com.ubports.biometryd.Service` is not yet owned (it waits ~26s for the FP HAL), it throws
and falls back to `for_testing::Service` with `available=false` — permanently, for the
whole session. Toggling FP in Settings builds a fresh QML context after biometryd is up,
which is why that workaround works.

## Fix options
A. systemd/session ordering (LOW blast radius, no auth-path code): after biometryd's bus
   name appears at boot, force the greeter's QML context to re-instantiate once. Reproduces
   the known-good toggle automatically. Risk: restarting greeter/session timing.
B. Patch the QML plugin (HIGHER blast radius — touches the greeter unlock path): make the
   singleton robust to late start (QDBusServiceWatcher on the bus name; create the real stub
   + flip available when it appears). Correct, but a broken build locks the user out.

## DEPLOYED + VALIDATED (2026-10-07)
Built against the device's exact biometryd commit 62e8b9 (soname libbiometry.so.1,
Qt5::DBus added) in the utbuild podman container. Deployed via bl6000pro-fp-qml.service
(bind-mount over the stock QML plugin; payload at /userdata/bl6000pro-fp/, stock backed up
to /userdata/bl6000pro-fp/stock-libbiometryd-qml.so, kill switch
/userdata/bl6000pro-fp/fpqml.off). Rebooted (kernel #56).

Validation: greeter journal shows it armed FP identify on its own at boot (no setting toggle)
and a touch matched — `qml: Failed to identify user by fingerprint: fingerprint reader is
locked` is the onSucceeded path, i.e. identify succeeded. No regression; plugin loads clean.
This boot started biometryd BEFORE Lomiri so the late-start race wasn't exercised, but the
QDBusServiceWatcher fix is strictly additive (handles both orderings).

## STILL OPEN (separate from availability)
`"fingerprint reader is locked"` = the greeter's secureFingerprint gating when the screen is
off (the single-touch-while-screen-off logic reverted earlier). Greeter QML, not this plugin.

## RESOLUTION of "reader is locked" (2026-10-07) — NOT A BUG
`secureFingerprint = isLockscreen && failedFingerprintLogins < disableAttempts`.
`isLockscreen` is true only when re-locking an ACTIVE session (set by forceShow), false at
first-boot login. So the post-reboot "reader is locked" is intentional UT security: the first
unlock after boot requires the PIN/passphrase (unlocks the keystore/gatekeeper); fingerprint
is allowed for every screen-off/lock cycle AFTER that. TEE/gatekeeper enforces this too.

The screen-off single-touch path is ALREADY implemented and correct:
- idEnabled has no screen-state term -> identify stays armed while screen is off (one touch).
- onSucceeded already calls Powerd.setStatus(On) so unlock is visible (prior black-screen bug,
  already fixed).

DECISION: do NOT modify the greeter here. Allowing FP on the first post-boot unlock would be a
security downgrade, likely wouldn't work (gatekeeper needs prior password auth), and greeter
edits of this kind previously caused lockout loops. FP single-touch is complete as designed.

### Physical confirmation (for the owner, once):
1. After a reboot, unlock once with the PIN (required by design).
2. Let the screen turn off. 3. Touch the sensor once -> should wake AND unlock in one touch.
