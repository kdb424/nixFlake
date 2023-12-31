{
  config,
  lib,
  pkgs,
  inputs,
  outputs,
  ...
}: {
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
