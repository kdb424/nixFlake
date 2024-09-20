{pkgs, ...}: {
  home.packages = with pkgs; [
    curl
    nodePackages.pnpm # betterdiscord
    unrar
    pywal
    comma # Unfortunate hack
  ];
}
