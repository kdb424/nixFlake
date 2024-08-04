{
  pkgs,
  lib,
  inputs,
  ...
}: let
  inherit (inputs) nixpkgs;
in {
  imports = [
    ../../common/darwin
  ];

  stylix = {
    autoEnable = true;
    image = pkgs.fetchurl {
      url = "https://git.kdb424.xyz/kdb424/wallpapers/raw/branch/main/wallhaven-kwk9o6.jpg";
      sha256 = "sha256-x2oFkDrt+96gd603hXC1T/FxpJJIuiI8xrww4REdzLE=";
    };
  };

  system.stateVersion = 4;
}
