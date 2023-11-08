{
  pkgs,
  lib,
  inputs,
  outputs,
  ...
}: let
  inherit (inputs) nixpkgs;
in {
  imports = [
    # inputs.home-manager.darwinModules.home-manager
    ./packages.nix
    ./yabai.nix
    ./yabai-scripting-additions.nix
  ];

  # home-manager.extraSpecialArgs = {inherit inputs outputs;};
  # home-manager.useGlobalPkgs = true;
  # home-manager.useUserPackages = true;

  users.users.kdb424 = {
    name = "kdb424";
    home = "/Users/kdb424";
    shell = pkgs.zsh;
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    vim
    home-manager
    iterm2
    gimp
  ];

  #security.pam.enableSudoTouchIdAuth = true;

  environment.shells = builtins.attrValues {inherit (pkgs) bashInteractive zsh;};

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;
  nix.extraOptions =
    ''
      # Determinate systems options
      build-users-group = nixbld
      bash-prompt-prefix = (nix:$name)\040
      max-jobs = auto
      extra-nix-path = nixpkgs=flake:nixpkgs
      experimental-features = nix-command flakes repl-flake
    ''
    + lib.optionalString (pkgs.system == "aarch64-darwin") ''
      extra-platforms = x86_64-darwin aarch64-darwin
    '';

  # pin nixpkgs in the system flake registry to the revision used
  # to build the config
  nix.registry.nixpkgs.flake = nixpkgs;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.overlays = [
    (final: prev:
      lib.optionalAttrs (prev.stdenv.system == "aarch64-darwin") {
        # Add access to x86 packages system is running Apple Silicon
        pkgs-x86 = import nixpkgs {
          system = "x86_64-darwin";
          config.allowUnfree = true;
        };
      })
  ];

  system.stateVersion = 4;
}
