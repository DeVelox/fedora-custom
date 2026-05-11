#!/bin/bash

set -ouex pipefail

# Terra
dnf5 -y install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release
# Niri
dnf5 -y install niri mako fuse nautilus gnome-keyring xfce-polkit
# Apps
dnf5 -y install atuin alacritty bat btop direnv eza fd-find fish helix ncdu \
nix-core podlet podman-compose quickemu ripgrep starship ugrep zellij zoxide

# Switch to bootc for updates
systemctl disable rpm-ostreed-automatic.timer
systemctl enable bootc-fetch-apply-updates.timer
sed -i 's/--apply //' /usr/lib/systemd/system/bootc-fetch-apply-updates.service

# Cleanup
dnf5 clean all
rm -rf /tmp/* || true
