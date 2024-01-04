{
  config,
  lib,
  pkgs,
  inputs,
  outputs,
  ...
}: {
  imports = [
    ./packages.nix
    ./users.nix
    ./locale.nix
    ./smart.nix
    # ./prometheus.nix
    ../../common/style/stylix.nix
  ];
  #
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  nix.settings.auto-optimise-store = true;
  nix.optimise.automatic = true;
  #nix.settings.keep-derivations = false; # saves space. Turn off for easier debugging

  nix.settings.trusted-users = [
    "root"
    "kdb424"
    "@wheel"
  ];

  # Disable so comma can be installed
  programs.command-not-found.enable = false;
  programs.nix-index-database.comma.enable = true;

  nix.gc = {
    automatic = true;
    dates = "monthly";
    options = "--delete-older-than 14d";
  };

  services.fstrim.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system we e ere taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
