# Fachii Linux (Allnine)

Fachii Linux is the Allnine "regular" edition: a Debian/Ubuntu-style live ISO with sane defaults, GNOME desktop, and a friendly ricing setup. The project is tuned to be built easily from WSL Ubuntu or a native Debian-based host using `live-build`.

## Requirements
- Debian/Ubuntu environment (WSL2 Ubuntu 22.04+ recommended)
- Packages: `live-build`, `debootstrap`, `squashfs-tools`, `xorriso`, `curl`, `wget`, `git`
- Sudo access for live-build steps

## Quick start
```bash
# From a clean shell
sudo apt update && sudo apt install -y live-build debootstrap squashfs-tools xorriso curl wget git
cd allnine-fachii
sudo ./build/build-fachii.sh
```

## What gets built
- ISO-hybrid image with GNOME desktop and the Fachii package set
- Custom neofetch ASCII art available for all new users (/etc/skel)
- Basic ricing preset files stored in `/rice`

## Output
After a successful build you will find the ISO in the project root:
```
fachii-linux-amd64.iso
```
Copy it to your preferred hypervisor, USB, or PXE workflow.
