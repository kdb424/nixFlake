{
  config,
  lib,
  pkgs,
  inputs,
  outputs,
  ...
}: {
  boot.supportedFilesystems = ["zfs"];
  boot.zfs.forceImportRoot = false;

  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;

  services.zfs = {
    trim = {
      enable = true;
      interval = "daily";
    };
    autoScrub = {
      enable = true;
      interval = "monthly";
    };
  };
  services.nfs.server.enable = true;
}
