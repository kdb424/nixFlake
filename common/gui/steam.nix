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
    gamescopeSession = {
      enable = true;
      args = [
        "-F fsr"
        "-f"
      ];
    };
  };
  environment.sessionVariables = {
    # Proton GE flag
    WINE_FULLSCREEN_FSR = "1";
  };
  environment.systemPackages = with pkgs; [
    protonup
  ];
}
