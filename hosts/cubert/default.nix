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

  #home-manager.users.kdb242 = import ../../home-manager/kdb424/hosts/macbook-darwin.nix;

  system.stateVersion = 4;
}
