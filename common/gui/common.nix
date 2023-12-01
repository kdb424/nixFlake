{pkgs, ...}: {
  services.printing.enable = true;

  hardware.keyboard.qmk.enable = true;

  environment.systemPackages = with pkgs; [
    qmk # Only install on headed machines
    gnome.adwaita-icon-theme
    gnome.gnome-themes-extra
    firefox-wayland
    qt5.qtwayland
    qt6.qmake
    qt6.qtwayland
    adwaita-qt
    adwaita-qt6
  ];
}
