{
  config,
  lib,
  pkgs,
  inputs,
  outputs,
  ...
}: let
    discord = pkgs.discord.override {withOpenASAR = true;};
    in
{
  # Enable CUPS to print documents.
  services.printing.enable = true;

  environment.systemPackages = with pkgs; [
    gnome.adwaita-icon-theme
    gnome.gnome-themes-extra
    firefox-wayland
    discord
    qt5.qtwayland
    qt6.qmake
    qt6.qtwayland
    adwaita-qt
    adwaita-qt6
  ];
}
