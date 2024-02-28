{
  config,
  lib,
  pkgs,
  ...
}: {
  services.lorri = {
    enable = true;
    enableNotifications = true;
  };
}
