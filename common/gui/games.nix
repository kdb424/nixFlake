{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./steam.nix
  ];

  # https://nixos.wiki/wiki/Gamemode
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    prismlauncher
    openjdk17
  ];
}
