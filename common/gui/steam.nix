{
  config,
  lib,
  pkgs,
  ...
}: {
  hardware.opengl.driSupport32Bit = true;

  nixpkgs.config.packageOverrides = pkgs: {
    steam = pkgs.steam.override {
      extraPkgs = pkgs:
        with pkgs; [
          xorg.libXcursor
          xorg.libXi
          xorg.libXinerama
          xorg.libXScrnSaver
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
          libkrb5
          keyutils
        ];
    };
  };

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
