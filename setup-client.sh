#!/usr/bin/env bash
set -euo pipefail

# If you ever want to change where repos go, modify this:
TARGET_DIR="${HOME}"

echo "Updating package list…"
sudo apt update

echo "Installing APT packages…"
sudo apt install -y python3-scapy python3-zeroconf python3-nmap python3-netifaces

echo "Installing asciichartpy via pip…"
sudo pip install asciichartpy --break-system-packages

echo "Cloning GitHub repositories into ${TARGET_DIR}…"
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
  DEST="${TARGET_DIR}/${repo}"
  if [ -d "${DEST}" ]; then
    echo "  → ${repo} already exists in ${TARGET_DIR}, skipping."
  else
    echo "  → Cloning ${repo} into ${TARGET_DIR}"
    git clone "https://github.com/austinhawthorne/${repo}.git" "${DEST}"
  fi
done

echo "Setup complete!"
