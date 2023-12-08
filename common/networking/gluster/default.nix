{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [./common.nix];

  services.glusterfs = {
    enable = true;
    # killMode = "process";
  };

  systemd.mounts = [
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
  ];
}
