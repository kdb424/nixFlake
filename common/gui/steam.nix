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
      extraPkgs = pkgs:
        with pkgs; [
          gamescope
        ];
    };
  };
}
