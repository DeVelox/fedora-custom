#!/bin/bash

set -ouex pipefail

# Nightly COSMIC COPR
# dnf5 -y copr enable ryanabx/cosmic-epoch
# dnf5 -y install cosmic-desktop
# dnf5 -y copr disable ryanabx/cosmic-epoch

# systemctl disable gdm.service
# systemctl enable cosmic-greeter.service

# Extra apps
dnf5 -y install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release
dnf5 -y install atuin alacritty bat btop direnv eza fd-find fish helix ncdu \
nix-core podlet podman-compose quickemu ripgrep starship ugrep zellij zoxide

# Switch to bootc for updates
systemctl disable rpm-ostreed-automatic.timer
systemctl enable bootc-fetch-apply-updates.timer
sed -i 's/--apply //' /usr/lib/systemd/system/bootc-fetch-apply-updates.service

# Cleanup
dnf5 clean all
rm -rf /tmp/* || true
