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
    image = pkgs.fetchurl {
      url = "https://git.kdb424.xyz/kdb424/wallpapers/raw/branch/main/wallhaven-zmomkv.jpg";
      sha256 = "sha256-vQIFAK9gzFl3DvDbyuM+MIvSW3OLL9IR1qn0hgsqnVU=";
    };
  };

  system.stateVersion = 4;
}
