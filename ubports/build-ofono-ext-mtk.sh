set -e
export DEBIAN_FRONTEND=noninteractive
apt-get update -qq && apt-get install -y -qq ca-certificates curl gnupg >/dev/null
curl -fsSL https://repo.ubports.com/keyring.gpg -o /etc/apt/trusted.gpg.d/ubports.gpg
echo "deb http://repo.ubports.com/ 24.04-1.x main" > /etc/apt/sources.list.d/ubports.list
apt-get update -qq
apt-get install -y -qq build-essential debhelper devscripts pkg-config libglib2.0-dev libglibutil-dev libgbinder-dev libgbinder-radio1-dev ofono-sailfish-dev libofonobinderpluginext-dev libandroid-properties-dev libhybris-dev >/dev/null
# source: git clone https://gitlab.com/ubports/development/core/hybris-support/ofono-binder-plugin-ext-mtk.git (master 7916201)
# run: podman run --rm --arch arm64 -v $PWD:/src docker.io/library/ubuntu:24.04 bash /src/build-ofono-ext-mtk.sh
cd /src/ofono-binder-plugin-ext-mtk
dch -v 0.8.0-0bl6000pro1 -D noble "Build master (2.0 IMtkRadioEx support) for BL6000 Pro" -b
dpkg-buildpackage -us -uc -b
