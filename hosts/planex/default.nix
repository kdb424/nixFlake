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
    ../../common/nixos/baremetal.nix
    # ./zfs.nix
    ../../common/networking/zerotier.nix
    #../../common/editors/emacs.nix
    ../../common/nixos/docker.nix
    #../../common/gui/games.nix
    #../../common/gui/steamUltrawide.nix
    #../../common/gui/hyprland.nix
    ../../common/style/stylix.nix
    ../../common/hardware/bluetooth.nix
    #../../common/hardware/amdgpu.nix
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

  # Latest stable kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
