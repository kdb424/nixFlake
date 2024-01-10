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
      what = "planex:/p3600";
      where = "/mnt/gp3600";
    }
    {
      type = "glusterfs";
      what = "planex:/docker";
      where = "/mnt/gdocker";
    }
    {
      type = "glusterfs";
      what = "planex:/media";
      where = "/mnt/gmedia";
    }
    {
      type = "glusterfs";
      what = "planex:/backups";
      where = "/mnt/gbackups";
    }
  ];
}
