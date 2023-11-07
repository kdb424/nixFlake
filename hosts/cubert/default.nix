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

  home-manager.users.kdb424 = import ../../home-manager/machines/cubert.nix;

  system.stateVersion = 4;
}
