{
  config,
  lib,
  pkgs,
  inputs,
  outputs,
  ...
}: {
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [3001];
  };
  services.hydra = {
    enable = true;
    port = 3001;
    hydraURL = "https://hydra.kdb424.xyz"; # externally visible URL
    notificationSender = "hydra@localhost"; # e-mail of hydra service
    # a standalone hydra will require you to unset the buildMachinesFiles list to avoid using a nonexistant /etc/nix/machines
    # buildMachinesFiles = [];
    # you will probably also want, otherwise *everything* will be built from scratch
    useSubstitutes = true;
    extraConfig = ''
      base_uri = https://hydra.kdb424.xyz
    '';
  };
  nix.buildMachines = [
    {
      hostName = "localhost";
      systems = [
        "i686-linux"
        "x86_64-linux"
      ];
      supportedFeatures = ["kvm" "nixos-test" "big-parallel" "benchmark"];
      maxJobs = 8;
    }
  ];
}
