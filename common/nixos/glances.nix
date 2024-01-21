{
  config,
  lib,
  pkgs,
  inputs,
  outputs,
  ...
}: {
  systemd.services.glances = {
    enable = true;
    description = "Services web server";
    unitConfig = {
      Type = "simple";
    };
    serviceConfig = {
      ExecStart = "${pkgs.glances}/bin/glances -w";
    };
    wantedBy = ["multi-user.target"];
  };
}
