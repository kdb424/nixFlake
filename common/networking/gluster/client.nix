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
      what = "morbo:/p3600";
      where = "/mnt/gp3600";
    }
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
      what = "morbo:/backups";
      where = "/mnt/gbackups";
    }
    {
      type = "glusterfs";
      what = "morbo:/minecraft";
      where = "/mnt/gminecraft";
    }
  ];
}
