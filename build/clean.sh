#!/bin/bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

echo "[fachii] Cleaning live-build artifacts..."
lb clean || true

echo "[fachii] Removing leftover ISO and temporary directories..."
rm -f live-image-*.iso live-image-*.hybrid.iso fachii-linux-amd64.iso
rm -rf binary chroot cache squashfs-root tmp

echo "[fachii] Clean complete."
