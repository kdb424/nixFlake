{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../common/nixos/baremetal.nix
    ../../common/networking/zerotier.nix
    ../../common/editors/emacs.nix
    ../../common/gui/games.nix
    ../../common/gui/hyprland.nix
    ../../common/style/stylix.nix
    ../../common/hardware/laptop.nix
    ../../common/nixos/remoteBuild.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;

  networking.hostName = "amy"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Enable firmware updates
  services.fwupd.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  nix.distributedBuilds = true;

  # Latest stable kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
