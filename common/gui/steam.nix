{
  config,
  lib,
  pkgs,
  ...
}: {
  hardware.opengl.driSupport32Bit = true;
  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraPkgs = pkgs: with pkgs; [
        gamescope
      ];
    };
  };

  # https://nixos.wiki/wiki/Gamemode
  programs.gamemode.enable = true;
}
