# Allnine Fachii Linux build assets

This repository contains the live-build configuration, branding, and theming presets for Fachii Linux (Allnine). Use the helper scripts under `build/` to produce a Debian-based ISO-hybrid image with custom neofetch branding.

Quick usage:
```bash
sudo apt update && sudo apt install -y live-build debootstrap squashfs-tools xorriso
sudo ./build/build-fachii.sh
```

See `docs/README.md` for prerequisites and `docs/BUILD_NOTES.md` for implementation details.
