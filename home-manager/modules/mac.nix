{pkgs, ...}: {
  imports = [
    ./alacritty/mac.nix
  ];

  home.packages = with pkgs; [
    curl
    nodePackages.pnpm # betterdiscord
    unrar
    pywal
  ];
}
