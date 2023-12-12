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
      what = "morbo:/docker";
      where = "/mnt/gdocker";
    }
    {
      type = "glusterfs";
      what = "morbo:/media";
      where = "/mnt/gmedia";
    }
    {
      type = "glusterfs";
      what = "morbo:/dockerdata";
      where = "/mnt/gdockerdata";
    }
    {
      type = "glusterfs";
      what = "morbo:/backups";
      where = "/mnt/gbackups";
    }
    {
      type = "glusterfs";
      what = "morbo:/airsonic";
      where = "/mnt/airsonic";
    }
    {
      type = "glusterfs";
      what = "morbo:/blog";
      where = "/mnt/blog";
    }
    {
      type = "glusterfs";
      what = "morbo:/gitea";
      where = "/mnt/gitea";
    }
    {
      type = "glusterfs";
      what = "morbo:/immich";
      where = "/mnt/immich";
    }
    {
      type = "glusterfs";
      what = "morbo:/jellyfin";
      where = "/mnt/jellyfin";
    }
    {
      type = "glusterfs";
      what = "morbo:/lounge";
      where = "/mnt/lounge";
    }
    {
      type = "glusterfs";
      what = "morbo:/printing";
      where = "/mnt/printing";
    }
    {
      type = "glusterfs";
      what = "morbo:/tdarr";
      where = "/mnt/tdarr";
    }
    {
      type = "glusterfs";
      what = "morbo:/ngircd";
      where = "/mnt/ngircd";
    }
  ];
}
