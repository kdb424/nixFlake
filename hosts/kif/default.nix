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
    ./zfs.nix
    ../../common/nixos/common.nix
    ../../common/networking/gluster.nix
    ../../common/networking/zerotier.nix
    ../../common/editors/emacs.nix
    ../../common/nixos/docker.nix
  ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/disk/by-id/ata-INTEL_SSDSC2KW256G8_BTLA733601VG256CGN ";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.configurationLimit = 10;

  networking.hostName = "kif"; # Define your hostname.
  # Enable networking
  networking.networkmanager.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Rips audio CD's
  environment.systemPackages = [
    pkgs.cdparanoia
    pkgs.flac
  ];
}
