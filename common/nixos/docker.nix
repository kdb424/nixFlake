{
  config,
  lib,
  pkgs,
  inputs,
  outputs,
  ...
}: {
  fileSystems."/mnt/docker" = {
    device = "morbo.far:/mnt/t7blue/docker";
    fsType = "nfs";
    options = ["x-systemd.automount" "noauto" "soft"];
  };

  virtualisation.docker = {
    enable = true;
    liveRestore = false;
    autoPrune = {
      enable = true;
      flags = ["--all"];
    };
  };

  users.users.kdb424.extraGroups = ["docker"];
  networking.firewall.enable = false;

  environment.systemPackages = with pkgs; [
    docker_24
  ];
}
