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
    kodi-wayland
    pavucontrol
    sublime-music
    sonixd
    thunderbird
    kicad
  ];
}
