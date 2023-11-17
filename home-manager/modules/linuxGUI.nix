{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    thunderbird
    betterdiscordctl
    gimp
    gparted
    kodi
    pavucontrol
    schildichat-desktop-wayland
    sublime-music
  ];

  services.protonmail-bridge = {
    enable = true;
    nonInteractive = true;
  };
}
