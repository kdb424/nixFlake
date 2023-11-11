{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./alacritty
  ];

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # fonts
    rPackages.fontawesome
    nerdfonts
    ubuntu_font_family
    noto-fonts-cjk-sans
    pywal
    yt-dlp
  ];
}
