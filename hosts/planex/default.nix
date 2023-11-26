{
  config,
  lib,
  pkgs,
  inputs,
  outputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    #./zfs.nix
    ../../common/nixos/common.nix
    ../../common/networking/zerotier.nix
    ../../common/editors/emacs.nix
    ../../common/nixos/docker.nix
    ../../common/gui/games.nix
    ../../common/gui/hyprland.nix
    ../../common/style/stylix.nix
    ../../common/hardware/bluetooth.nix
    ../../common/hardware/amdgpu.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;

  networking.hostName = "planex";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Logitech G502 stuff
  # services.hardware.openrgb.enable = true;
  # services.ratbagd.enable = true;
  # environment.systemPackages = with pkgs; [
  #   openrgb-with-all-plugins
  #   piper
  # ];
}
