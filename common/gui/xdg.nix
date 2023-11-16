{
  config,
  lib,
  pkgs,
  ...
}: {
  # XDG Portals
  xdg = {
    autostart.enable = true;
    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
    };
  };
  environment.systemPackages = with pkgs; [
    xdg-utils
    xdg-desktop-portal
    xdg-desktop-portal-gtk
  ];

  environment.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
  };
}
