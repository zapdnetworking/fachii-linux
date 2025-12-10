#!/bin/bash
# Fachii Linux build helper
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_DIR="$ROOT_DIR/config"
BRANDING_DIR="$ROOT_DIR/branding/neofetch"
INCLUDES_DIR="$CONFIG_DIR/includes.chroot/usr/share/allnine-fachii/neofetch"
PACKAGE_LIST="$CONFIG_DIR/packages-fachii.list.chroot"
PACKAGE_DEST_DIR="$CONFIG_DIR/package-lists"

log() { echo "[fachii] $*"; }

log "Preparing live-build configuration..."
"$CONFIG_DIR/lb-config.sh"

log "Refreshing package lists..."
mkdir -p "$PACKAGE_DEST_DIR"
cp "$PACKAGE_LIST" "$PACKAGE_DEST_DIR/fachii.list.chroot"

log "Syncing neofetch branding into includes..."
mkdir -p "$INCLUDES_DIR"
cp "$BRANDING_DIR/ascii-fachii.txt" "$INCLUDES_DIR/ascii.txt"
cp "$BRANDING_DIR/config.conf" "$INCLUDES_DIR/config.conf"

log "Ensuring hooks are executable..."
find "$CONFIG_DIR/hooks" -maxdepth 1 -type f -print -exec chmod +x {} \;

log "Starting live-build (sudo may prompt for password)..."
cd "$ROOT_DIR"
sudo lb build

OUTPUT_NAME="fachii-linux-amd64.iso"
if [ -f live-image-amd64.hybrid.iso ]; then
  mv live-image-amd64.hybrid.iso "$OUTPUT_NAME"
elif ls live-image-*.hybrid.iso >/dev/null 2>&1; then
  FOUND_ISO=$(ls live-image-*.hybrid.iso | head -n1)
  mv "$FOUND_ISO" "$OUTPUT_NAME"
else
  log "No ISO produced; check live-build logs."
  exit 1
fi

log "Build complete: $OUTPUT_NAME"
