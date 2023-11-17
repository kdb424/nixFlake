{
  config,
  lib,
  pkgs,
  inputs,
  outputs,
  ...
}: let
  # discord = pkgs.discord.override {
  #   # Performance mod
  #   withOpenASAR = true;
  #   # link fix
  #   nss = pkgs.nss_latest;
  # };
in {
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
