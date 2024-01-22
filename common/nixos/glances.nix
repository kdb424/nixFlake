{
  config,
  lib,
  pkgs,
  inputs,
  outputs,
  ...
}: {
  networking.firewall = {
    allowedTCPPorts = [61208];
  };
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
