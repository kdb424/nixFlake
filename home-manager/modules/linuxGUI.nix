{pkgs, ...}: {
  imports = [
    ./discord
    ./games.nix
  ];

  programs.discord = {
    enable = true;
    wrapDiscord = false;
  };

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
