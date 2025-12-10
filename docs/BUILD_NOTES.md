# Build Notes

Fachii Linux uses Debian live-build to assemble an ISO-hybrid image. This document walks through how the pieces fit together and where to extend the distribution.

## Live-build overview
- `config/lb-config.sh` sets up `lb config` for Debian Bookworm, amd64, ISO-hybrid, and live installer mode.
- `build/build-fachii.sh` runs the configuration, syncs assets, and calls `sudo lb build`.
- `build/clean.sh` resets the workspace by removing `lb` artifacts and previous ISO outputs.

## Directory map
- `config/` – live-build settings, package lists, hooks, and includes.
  - `packages-fachii.list.chroot` – base package list; copied to `config/package-lists/` before building.
  - `hooks/01-neofetch-skel.hook.chroot` – injects neofetch ASCII + config into `/etc/skel` inside the image.
  - `includes.chroot/usr/share/allnine-fachii/neofetch/` – asset staging for the hook to copy.
- `branding/` – source branding assets (ASCII art, config, placeholders for grub/wallpapers/icons).
- `rice/fachii-frost/` – ricing preset files for later manual application.
- `flavors/` – placeholder package lists for Kachii, Secahii, and Gambite Aura.
- `build/` – build + clean helper scripts.
- `docs/` – you are here.

## Neofetch + ASCII wiring
1. Branding lives in `branding/neofetch/` (ASCII + config).
2. `build/build-fachii.sh` copies those files to `config/includes.chroot/usr/share/allnine-fachii/neofetch/`.
3. During the chroot stage, `config/hooks/01-neofetch-skel.hook.chroot` copies the assets into `/etc/skel/.config/neofetch/`.
4. Every new user session in the live system inherits the custom ASCII art and themed configuration.

## Package lists
- Base desktop: `config/packages-fachii.list.chroot` (mirrored into `config/package-lists/fachii.list.chroot`).
- Flavors:
  - `flavors/kachii/packages-kachii.list.chroot` – dev tools starting point.
  - `flavors/secahii/packages-secahii.list.chroot` – gaming stack starting point.
  - `flavors/gambite-aura/packages-gambite-aura.list.chroot` – security tooling starting point.
- To add packages, append them to the relevant `*.list.chroot` file. `lb` will include them at build time.

## Adding more flavors later
1. Duplicate one of the existing flavor folders under `flavors/`.
2. Expand its `packages-<flavor>.list.chroot` with your packages.
3. Update `build/build-fachii.sh` or create a new build script to point to that list if you want an automated flavor build.

## Running in WSL
- Install dependencies:
  ```bash
  sudo apt update && sudo apt install -y live-build debootstrap squashfs-tools xorriso
  ```
- Some WSL builds restrict loop devices or mounting. If `lb build` fails with mount/loop errors, enable WSL2 and ensure virtualization is allowed, or retry on a native Debian/Ubuntu host.
- Recommended invocation inside WSL2 Ubuntu:
  ```bash
  cd allnine-fachii
  sudo ./build/build-fachii.sh
  ```
- Expect downloads of package archives; ensure your WSL distro has sufficient disk space.

## Applying the ricing preset
- The `rice/fachii-frost/` directory contains configs for neofetch, alacritty, polybar, and a Hyprland template, plus a font list and wallpaper placeholders.
- After booting the live system or an installed system, manually copy these files into your home directory (e.g., `~/.config/neofetch/config.conf`, `~/.config/alacritty/alacritty.yml`, etc.).
- Install the fonts listed in `rice/fachii-frost/fonts.txt` and place your chosen wallpaper files into `rice/fachii-frost/wallpapers/`, then set them via your desktop environment.
