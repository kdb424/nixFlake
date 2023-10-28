{
  config,
  lib,
  pkgs,
  ...
}: {
  gtk = {
    enable = true;
    theme = {
      name = "FlatColor";
    };
  };
  home.packages = with pkgs; [
    firefox
    wpgtk
    lxappearance
    discord
    betterdiscordctl
    gimp
    gparted
    kodi
    pavucontrol
    schildichat-desktop-wayland
    sublime-music
  ];
}
