{
  pkgs,
  lib,
  inputs,
  ...
}: let
  inherit (inputs) nixpkgs;
in {
  imports = [
    ../../common/darwin/common.nix
  ];

  system.stateVersion = 4;
}
