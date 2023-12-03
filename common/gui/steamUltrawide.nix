{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.steam.gamescopeSession.args = [
    "-w 2560"
    "-h 1080"
    "-W 3440"
    "-H 1440"
  ];
}
