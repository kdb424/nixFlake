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
      where = "/mnt/gbackups";
    }
    {
      wantedBy = ["multi-user.target"];
      where = "/mnt/gminecraft";
    }
  ];
}
