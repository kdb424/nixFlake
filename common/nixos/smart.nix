{ config, lib, pkgs, ... }:

{

  services.smartd = {
    enable = true;
    notifications.wall.enable = true;
  };
}
