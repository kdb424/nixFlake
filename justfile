# Build the system config and switch to it when running `just` with no args
default: switch

hostname := `hostname | cut -d "." -f 1`

# Build the nix-darwin system configuration without switching to it
[macos]
build target_host=hostname flags="":
  @echo "Building nix-darwin config..."
  nix --extra-experimental-features 'nix-command flakes'  build ".#darwinConfigurations.{{target_host}}.system" {{flags}}

# Build the nix-darwin config with the --show-trace flag set
[macos]
trace target_host=hostname: (build target_host "--show-trace")

# Build the nix-darwin configuration and switch to it
[macos]
switch target_host=hostname: (build target_host)
  #!/usr/bin/env bash
  set -euxo pipefail
  echo "switching to new config for {{target_host}}"
  # If this file doesn't exist, this fails. Touch it
  if ! test -f /etc/shells; then
    sudo touch /etc/shells
  fi
  if test -f /etc/bashrc; then
    sudo mv /etc/bashrc /etc/bashrc.before.nix
  fi
  # if macOS updates and overwrites /etc/shells, nix will refuse to update it
  if test -f /etc/shells; then
    sudo mv /etc/shells /tmp/shells.bak
  fi
  ./result/sw/bin/darwin-rebuild switch --flake ".#{{target_host}}"

# Reload the skhd (hotkey daemon) service to apply new config. Workaround for config changes not being auto-detected.
[macos]
reload-skhd:
  launchctl stop org.nixos.skhd && launchctl start org.nixos.skhd && sleep 1 && skhd -r

# on asahi linux, we need to pass the --impure flag to read in firmware files
rebuild_flags := `if [ -d /boot/asahi ]; then echo "--impure"; else echo ""; fi`


# Build the NixOS configuration without switching to it
[linux]
build target_host=hostname flags="":
	nixos-rebuild build --flake .#{{target_host}} {{rebuild_flags}} {{flags}}

# Build the NixOS configuration without switching to it
[linux]
build-vm target_host=hostname flags="":
	nixos-rebuild build-vm --flake .#{{target_host}} {{rebuild_flags}} {{flags}}

# Build the NixOS config with the --show-trace flag set
[linux]
trace target_host=hostname: (build target_host "--show-trace")

# Build the NixOS configuration and switch to it.
[linux]
switch target_host=hostname:
  sudo nixos-rebuild switch --flake .#{{target_host}} {{rebuild_flags}}

# Build the NixOS configuration remotely and switch to it.
[linux]
remote target_host=hostname:
  sudo nixos-rebuild switch --flake .#{{target_host}} {{rebuild_flags}} --max-jobs 1 --builders @/etc/nix/machines

# Build the NixOS configuration and switch to it on next boot.
[linux]
boot target_host=hostname:
  sudo nixos-rebuild boot --flake .#{{target_host}} {{rebuild_flags}}

# Garbage collect old OS generations and remove stale packages from the nix store
gc generations="5d":
  sudo nix-env --delete-generations {{generations}}
  sudo nix-store --gc

# Build home manager
hm-build:
  #!/usr/bin/env bash
  # If this directory doesn't exist, build will fail
  if ! test -f ~/.local/state/nix/profiles; then
    mkdir -p ~/.local/state/nix/profiles
  fi
  home-manager build --flake .

# Switch to home manager
hm-switch:
  #!/usr/bin/env bash
  # If this directory doesn't exist, build will fail
  if ! test -f ~/.local/state/nix/profiles; then
    mkdir -p ~/.local/state/nix/profiles
  fi
  home-manager switch --flake .

# Nuclear option to get space back
gc-full:
  sudo nix-env --delete-generations old
  sudo nix-store --gc
