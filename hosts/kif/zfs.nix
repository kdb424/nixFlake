{
  config,
  lib,
  pkgs,
  inputs,
  outputs,
  ...
}: {
  networking.hostId = "4b0bddd5";
  boot.zfs.extraPools = ["t7blue"];

  boot.supportedFilesystems = ["zfs"];
  boot.zfs.forceImportRoot = false;

  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;

  # Enable mail server for zed
  nixpkgs.config.packageOverrides = pkgs: {
    zfsStable = pkgs.zfsStable.override { enableMail = true; };
  };

  services.zfs = {
    trim = {
      enable = true;
      interval = "daily";
    };
    autoSnapshot = {
      enable = true;
    };
    autoScrub = {
      enable = true;
      interval = "monthly";
    };
    zed = {
      enableMail = true;
      settings = {
        ZED_EMAIL_ADDR = ["zfs@kdb424.xyz"];
        ZED_EMAIL_OPTS = "-s '@SUBJECT@' @ADDRESS@";

        ZED_NOTIFY_INTERVAL_SECS = 3600;
        ZED_NOTIFY_VERBOSE = false;
        ZED_SCRUB_AFTER_RESILVER = true;
      };
    };
  };
  services.nfs.server.enable = true;
}
