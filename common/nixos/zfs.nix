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
    zed.settings = {
      # Latest docs
      # https://github.com/openzfs/zfs/blob/master/cmd/zed/zed.d/zed.rc

      # disable after testing
      ZED_NOTIFY_VERBOSE = true;

      ZED_USE_ENCLOSURE_LEDS = true;
      ZED_SCRUB_AFTER_RESILVER = true;
      ##
      # Ntfy topic
      # This defines which topic will receive the ntfy notification.
      #  <https://docs.ntfy.sh/publish/>
      # Disabled by default; uncomment to enable.
      ZED_NTFY_TOPIC = "zfs";

      ##
      # Ntfy access token (optional for public topics)
      # This defines an access token which can be used
      # to allow you to authenticate when sending to topics
      # <https://docs.ntfy.sh/publish/#access-tokens>
      # Disabled by default; uncomment to enable.
      #ZED_NTFY_ACCESS_TOKEN = "";

      ##
      # Ntfy Service URL
      # This defines which service the ntfy call will be directed toward
      #  <https://docs.ntfy.sh/install/>
      # https://ntfy.sh by default; uncomment to enable an alternative service url.
      ZED_NTFY_URL = "https://ntfy.kdb424.xyz";
    };
  };
  services.nfs.server.enable = true;
}
