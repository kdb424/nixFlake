{pkgs, ...}: {
  imports = [
    ./kitty/mac.nix
  ];

  home.packages = with pkgs; [
    curl
    nodePackages.pnpm # betterdiscord
    unrar
    pywal
    comma # Unfortunate hack
    kitty
  ];
}
