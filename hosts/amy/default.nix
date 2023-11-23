{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../common/nixos/common.nix
    ../../common/networking/zerotier.nix
    ../../common/editors/emacs.nix
    ../../common/gui/steam.nix
    ../../common/gui/hyprland.nix
    ../../common/style/stylix.nix
    ../../common/nixos/laptop.nix
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
}
