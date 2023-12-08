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
  ];
}
