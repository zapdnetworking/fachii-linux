#!/bin/bash
# Fachii Linux live-build configuration script
# Make executable: chmod +x config/lb-config.sh
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "$SCRIPT_DIR/.."

echo "[fachii] Cleaning previous configuration..."
lb clean || true

# Configure live-build for Fachii Linux
# Adjust distribution/archives to switch between Debian and Ubuntu bases
lb config \
  --distribution bookworm \
  --architectures amd64 \
  --binary-images iso-hybrid \
  --debian-installer live \
  --archive-areas "main contrib non-free non-free-firmware" \
  --apt-recommends true \
  --bootappend-live "boot=live components quiet splash" \
  --iso-volume "Fachii Linux" \
  --iso-preparer "Allnine" \
  --iso-publisher "Allnine - Fachii Linux" \
  --mirror-bootstrap http://deb.debian.org/debian/ \
  --mirror-binary http://deb.debian.org/debian/ \
  --updates true \
  --security true \
  --firmware-chroot true \
  --firmware-binary true

echo "[fachii] live-build configured."
