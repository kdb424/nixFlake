# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
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
    ../../common/gui/hyprland.nix
    ../../common/editors/emacs.nix
  ];
  # home-manager.users.kdb424 = import ../../home-manager/machines/amy.nix;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "amy"; # Define your hostname.
  networking.networkmanager.enable = true;

  services.fwupd.enable = true;
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
}
