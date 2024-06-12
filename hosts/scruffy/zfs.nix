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
  networking.hostId = "4b0bddd5";
  boot.zfs.extraPools = ["inland"];

  services.zfs.autoSnapshot.enable = true;
}
