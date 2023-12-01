{pkgs, ...}: {
  imports = [
    ./discord
  ];

  programs.discord = {
    enable = true;
    wrapDiscord = false;
  };

  programs.mangohud.enable = true;

  home.packages = with pkgs; [
    betterdiscordctl
    gimp
    gparted
    kodi-wayland
    pavucontrol
    schildichat-desktop-wayland
    sublime-music
    thunderbird
    kicad
  ];
}
