{
  config,
  lib,
  pkgs,
  inputs,
  outputs,
  ...
}: {
  fileSystems."/mnt/docker" = {
    device = "planex.far:/mnt/exos/docker";
    fsType = "nfs";
    options = ["x-systemd.automount" "noauto"];
  };

  virtualisation.docker.enable = true;
  virtualisation.docker.liveRestore = false;
  users.users.kdb424.extraGroups = ["docker"];

  environment.systemPackages = with pkgs; [
    docker_24
  ];
}
