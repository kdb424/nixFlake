{
  config,
  lib,
  pkgs,
  inputs,
  outputs,
  ...
}: {
  imports = [
    ../../common/nixos/zfs.nix
  ];
  networking.hostId = "dbcb155c";
  boot.zfs.extraPools = ["red"];

  services.zfs.autoSnapshot.enable = true;
}
