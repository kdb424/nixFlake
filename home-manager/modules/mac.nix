{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    curl
    nodePackages.pnpm # betterdiscord
    unrar
  ];
}
