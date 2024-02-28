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
      url = "https://w.wallhaven.cc/full/6k/wallhaven-6kv1ow.png";
      sha256 = "sha256-b3EAkJpstDRm3VyJzuT7ACg6K0y2W5EMbf7qBZQBhi4=";
    };
  };

  system.stateVersion = 4;
}
