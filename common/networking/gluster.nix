{ config, lib, pkgs, ... }:

{
  services.glusterfs = {
    enable = true;
    # killMode = "process";
  };
}
