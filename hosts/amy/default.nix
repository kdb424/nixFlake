{
  config,
  lib,
  pkgs,
  inputs,
  outputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../common/nixos/common.nix
    ../../common/networking/zerotier.nix
    ../../common/editors/emacs.nix
    ../../common/nixos/bluetooth.nix
    ../../common/gui/steam.nix
    ../../common/gui/hyprland.nix
    ../../common/style/stylix.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "amy"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Enable firmware updates
  services.fwupd.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # use TLP for power management
  services.tlp.enable = true;
}
