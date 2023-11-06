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
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../common/nixos/common.nix
    ../../common/nixos/docker.nix
    ../../common/networking/zerotier.nix
    ../../common/editors/emacs.nix
    # Include the necessary packages and configuration for Apple Silicon support.
    inputs.apple-silicon.nixosModules.apple-silicon-support
  ];

  home-manager.users.kdb424 = import ../../home-manager/machines/headless.nix;

  # Specify path to peripheral firmware files.
  hardware.asahi.peripheralFirmwareDirectory = ./firmware;

  # Build the kernel with 4K pages to improve software compatibility at
  # the cost of performance in some cases.
  # hardware.asahi.use4KPages = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  networking.hostName = "farnsworth"; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
}
