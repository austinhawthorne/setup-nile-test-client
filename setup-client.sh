#!/usr/bin/env bash
set -euo pipefail

# Determine who “owns” the cloned repos:
if [[ $EUID -eq 0 && -n "${SUDO_USER:-}" && "${SUDO_USER}" != "root" ]]; then
  TARGET_USER="$SUDO_USER"
  TARGET_HOME="$(eval echo "~${SUDO_USER}")"
else
  TARGET_USER="$(id -un)"
  TARGET_HOME="${HOME}"
fi

echo "→ Cloning into ${TARGET_HOME} (owner: ${TARGET_USER})"
echo

echo "→ Updating apt package list…"
sudo apt update

echo "→ Installing APT packages…"
sudo apt install -y python3-scapy python3-zeroconf python3-nmap python3-netifaces

echo "→ Installing asciichartpy via pip…"
sudo pip install asciichartpy --break-system-packages

echo
echo "→ Cloning GitHub repositories…"
REPOS=(
  rogue-dhcp-test
  loop-detector
  dot1x-test
  simple-mcast-test
  simple-airplay
  net-scan
  staticip-test
)

for repo in "${REPOS[@]}"; do
  dest="${TARGET_HOME}/${repo}"
  if [[ -d "$dest" ]]; then
    echo "   • ${repo} already exists at ${dest}, skipping."
  else
    echo "   • Cloning ${repo} → ${dest}"
    if [[ "${TARGET_USER}" != "$(id -un)" ]]; then
      sudo -u "${TARGET_USER}" git clone "https://github.com/austinhawthorne/${repo}.git" "$dest"
    else
      git clone "https://github.com/austinhawthorne/${repo}.git" "$dest"
    fi
  fi
done

echo
echo "✔ All done!"
