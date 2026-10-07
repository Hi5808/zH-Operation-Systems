#!/usr/bin/env bash
#
# ut-dev.sh - fast dev loop for the BL6000 Pro Ubuntu Touch port.
#
#   ut-dev.sh ip                 print the phone's USB-network address
#   ut-dev.sh ssh [cmd...]       ssh as root (auto-detects the address)
#   ut-dev.sh wait               wait until SSH answers (after a reboot)
#   ut-dev.sh reboot             clean reboot over SSH, then wait for SSH
#   ut-dev.sh flash-boot [img]   wait for fastboot, flash boot, reboot, wait for SSH
#   ut-dev.sh build-boot         rebuild ut-boot.img from out-halium + initramfs
#   ut-dev.sh logs               failed units + compositor/lomiri log tails
#
# Notes:
# - Before user setup the phone is <USB_IP> (usb-moded rndis);
#   after setup NetworkManager shares the link and the phone is <USB_IP>.
# - Entering fastboot needs a human: power off, Vol-Up + Power, pick Fastboot.
#
set -euo pipefail
W=${W:-$HOME/bl6000pro-work}
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
IPS="${BL6000_IP:-} <USB_IP> <USB_IP> <LAN_IP> <LAN_IP>"
SSHOPT=(-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o LogLevel=ERROR -o ConnectTimeout=5)
CMDLINE="bootopt=64S3,32N2,64N2 console=tty0 loop.max_part=7 printk.devkmsg=on"

find_ip() {
    for ip in $IPS; do
        timeout 2 bash -c "echo > /dev/tcp/$ip/22" 2>/dev/null && { echo "$ip"; return 0; }
    done
    return 1
}

wait_ssh() {
    local t=${1:-240} i=0
    printf 'waiting for SSH'
    until ip=$(find_ip); do
        sleep 3; i=$((i+3)); printf '.'
        [ $i -ge "$t" ] && { echo " timeout"; return 1; }
    done
    echo " up at $ip"
}

phone() { local ip; ip=$(find_ip) || { echo "phone not reachable" >&2; exit 1; }; ssh "${SSHOPT[@]}" "root@$ip" "$@"; }

case "${1:-}" in
    ip) find_ip || { echo "not reachable"; exit 1; } ;;
    ssh) shift; phone "$@" ;;
    wait) wait_ssh ;;
    reboot) phone 'systemctl reboot' || true; sleep 15; wait_ssh ;;
    build-boot)
        "$HERE/repack-boot.sh" "$W/out-halium/arch/arm64/boot/Image.gz" "$W/ut/initrd-dynparts.img" \
            "$W/ut/stock-dtb.img" "$W/test-images/ut-boot.img" "$CMDLINE" >/dev/null
        echo "built $W/test-images/ut-boot.img" ;;
    flash-boot)
        img=${2:-$W/test-images/ut-boot.img}
        echo "Put the phone in fastboot (Vol-Up + Power -> Fastboot)."
        until fastboot devices | grep -q .; do sleep 2; done
        fastboot flash boot "$img"
        fastboot reboot
        sleep 15; wait_ssh ;;
    logs)
        phone 'systemctl --failed --no-legend; echo "== compositor"; tail -5 /var/log/lightdm/unity-system-compositor.log;
               echo "== lomiri"; journalctl -b --no-pager -o cat | grep -E "^\[.*\] (qtmir|qml|lomiri)" | tail -15' ;;
    *) sed -n '3,18p' "$0"; exit 1 ;;
esac
