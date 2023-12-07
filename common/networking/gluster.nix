{
  config,
  lib,
  pkgs,
  ...
}: {
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
  ];

  systemd.automounts = [
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
  ];

}
