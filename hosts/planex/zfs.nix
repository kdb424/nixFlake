{
  config,
  lib,
  pkgs,
  inputs,
  outputs,
  ...
}: {
  imports = [
    ../../common/nixos/zfs.nix
  ];
  networking.hostId = "eb081e21";
  boot.zfs.extraPools = ["exos"];
  boot.kernelParams = ["zfs.zfs_arc_max=8589934592"]; # 8GB

  services.zfs.autoSnapshot = {
    enable = true;
    frequent = 4;
    hourly = 24;
    daily = 7;
    weekly = 4;
    monthly = 0;
  };

  users.users.zfs = {
    isNormalUser = true;
    description = "ZFS management";
    uid = 5000;
    initialHashedPassword = "$6$8MS0DbAybsWGJt4a$zIX6v7qP3zS.uoJRv2jknz.KZ7QESNPGK.EvJ1Z0o8XDgDTZaYSAGRZ6dfRrl/22IS2DVogjAAgS15QJCcLwG1";
  };
}
