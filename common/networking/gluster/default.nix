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
      what = "127.0.0.1:/backups";
      where = "/mnt/gbackups";
    }
    {
      type = "glusterfs";
      what = "127.0.0.1:/minecraft";
      where = "/mnt/gminecraft";
    }
  ];
}
