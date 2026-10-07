#!/bin/sh
# BL6000 Pro dev image: fix home ownership, skip the setup wizard, install the
# dev SSH key for phablet. Safe to run on every boot (idempotent).
H=/home/phablet
[ -d $H ] || exit 0
chown 32011:32011 $H
for d in .config .config/lomiri .ssh; do mkdir -p $H/$d; chown 32011:32011 $H/$d; done
chmod 700 $H/.ssh
if [ ! -s $H/.ssh/authorized_keys ]; then
    cp /usr/share/bl6000pro/dev-authorized_keys $H/.ssh/authorized_keys
    chown 32011:32011 $H/.ssh/authorized_keys; chmod 600 $H/.ssh/authorized_keys
fi
# Wizard skip is for DEV images only (official builds run the setup wizard).
[ -e /usr/share/bl6000pro/dev-image ] || exit 0
F=$H/.config/lomiri/wizard-has-run
[ -s $F ] || { cat "$(readlink -f /usr/share/click/frameworks/current)" > $F; chown 32011:32011 $F; }
