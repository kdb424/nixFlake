{
  config,
  lib,
  pkgs,
  ...
}: {
  services.glusterfs = {
    enable = true;
    killMode = "process";
  };

  systemd.automounts = [
    {
      wantedBy = ["multi-user.target"];
      where = "/mnt/gp3600";
    }
    {
      wantedBy = ["multi-user.target"];
      where = "/mnt/gdocker";
    }
    {
      wantedBy = ["multi-user.target"];
      where = "/mnt/gmedia";
    }
    {
      wantedBy = ["multi-user.target"];
      where = "/mnt/gdockerdata";
    }
    {
      wantedBy = ["multi-user.target"];
      where = "/mnt/gbackups";
    }
    {
      wantedBy = ["multi-user.target"];
      where = "/mnt/airsonic";
    }
    {
      wantedBy = ["multi-user.target"];
      where = "/mnt/blog";
    }
    {
      wantedBy = ["multi-user.target"];
      where = "/mnt/gitea";
    }
    {
      wantedBy = ["multi-user.target"];
      where = "/mnt/immich";
    }
    {
      wantedBy = ["multi-user.target"];
      where = "/mnt/jellyfin";
    }
    {
      wantedBy = ["multi-user.target"];
      where = "/mnt/lounge";
    }
    {
      wantedBy = ["multi-user.target"];
      where = "/mnt/printing";
    }
    {
      wantedBy = ["multi-user.target"];
      where = "/mnt/tdarr";
    }
  ];
}
