{
  config,
  lib,
  pkgs,
  inputs,
  outputs,
  ...
}:
{
  fileSystems."/mnt/docker" = {
    device = "planex.far:/mnt/exos/docker";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" ];
  };

  virtualisation.docker.enable = true;
  users.users.kdb424.extraGroups = [ "docker" ];

}
