{
  config,
  lib,
  pkgs,
  ...
}: {
  # gtk = {
  #   enable = true;
  #   theme = {
  #     name = "FlatColor";
  #   };
  # };
  home.packages = with pkgs; [
    firefox
    betterdiscordctl
    gimp
    gparted
    kodi
    pavucontrol
    schildichat-desktop-wayland
    sublime-music
  ];
}
