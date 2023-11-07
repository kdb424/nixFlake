{
  config,
  lib,
  pkgs,
  inputs,
  outputs,
  home-manager,
  ...
}: {
  home-manager.users.kdb424 = import ../../home-manager/machines/headless.nix;

  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./zfs.nix
    ../../common/nixos/common.nix
    ../../common/networking/zerotier.nix
    ../../common/editors/emacs.nix
    ../../common/nixos/docker.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "morbo";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
}
