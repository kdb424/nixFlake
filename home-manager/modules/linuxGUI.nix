{pkgs, ...}: {
  imports = [
    ./discord
  ];

  programs.discord = {
    enable = true;
    wrapDiscord = true;
  };

  home.packages = with pkgs; [
    betterdiscordctl
    gimp
    gparted
    kodi
    pavucontrol
    schildichat-desktop-wayland
    sublime-music
    thunderbird
    kicad
  ];
}
