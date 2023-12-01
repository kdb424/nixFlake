{
  config,
  lib,
  pkgs,
  ...
}: {
  hardware.opengl.driSupport32Bit = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    gamescopeSession.enable = true;
  };
}
