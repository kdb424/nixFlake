{
  config,
  lib,
  pkgs,
  inputs,
  outputs,
  ...
}: {
  nix.buildMachines = [
    {
      hostName = "calculon";
      sshUser = "kdb424";
      systems = [
        "i686-linux"
        "x86_64-linux"
        "aarch64-linux"
      ];
      protocol = "ssh-ng";
      supportedFeatures = ["kvm" "nixos-test" "big-parallel" "benchmark"];
      speedFactor = 4;
      maxJobs = 8;
    }
    {
      hostName = "planex";
      sshUser = "kdb424";
      systems = ["i686-linux" "x86_64-linux" "aarch64-linux"];
      protocol = "ssh-ng";
      supportedFeatures = ["kvm" "nixos-test" "big-parallel" "benchmark"];
      speedFactor = 3;
      maxJobs = 4;
    }
  ];

  nix.distributedBuilds = true;
  # optional, useful when the builder has a faster internet connection than yours
  nix.extraOptions = ''
    builders-use-substitutes = true
  '';
}
