{
  config,
  lib,
  pkgs,
  inputs,
  outputs,
  home-manager,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../common/nixos/common.nix
    ../../common/networking/zerotier.nix
    ../../common/editors/emacs.nix
    ../../common/nixos/docker.nix
  ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;
  networking.hostName = "scruffy";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.earlyoom.enable = true;

  # Proxmox additions
  services.qemuGuest.enable = true;

  # Latest stable kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
