{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [./common.nix];

  services.glusterfs = {
    enable = true;
  };

  systemd.mounts = [
    {
      type = "glusterfs";
      what = "127.0.0.1:/p3600";
      where = "/mnt/gp3600";
    }
    {
      type = "glusterfs";
      what = "127.0.0.1:/docker";
      where = "/mnt/gdocker";
    }
    {
      type = "glusterfs";
      what = "127.0.0.1:/media";
      where = "/mnt/gmedia";
    }
    {
      type = "glusterfs";
      what = "127.0.0.1:/dockerdata";
      where = "/mnt/gdockerdata";
    }
    {
      type = "glusterfs";
      what = "127.0.0.1:/backups";
      where = "/mnt/gbackups";
    }
    {
      type = "glusterfs";
      what = "127.0.0.1:/airsonic";
      where = "/mnt/airsonic";
    }
    {
      type = "glusterfs";
      what = "127.0.0.1:/blog";
      where = "/mnt/blog";
    }
    {
      type = "glusterfs";
      what = "127.0.0.1:/gitea";
      where = "/mnt/gitea";
    }
    {
      type = "glusterfs";
      what = "127.0.0.1:/immich";
      where = "/mnt/immich";
    }
    {
      type = "glusterfs";
      what = "127.0.0.1:/jellyfin";
      where = "/mnt/jellyfin";
    }
    {
      type = "glusterfs";
      what = "127.0.0.1:/lounge";
      where = "/mnt/lounge";
    }
    {
      type = "glusterfs";
      what = "127.0.0.1:/printing";
      where = "/mnt/printing";
    }
    {
      type = "glusterfs";
      what = "127.0.0.1:/tdarr";
      where = "/mnt/tdarr";
    }
  ];
}
