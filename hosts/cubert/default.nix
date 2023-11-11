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

  system.stateVersion = 4;
}
