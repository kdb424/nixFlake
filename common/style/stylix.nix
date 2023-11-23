{pkgs, ...}: {
  stylix = {
    image = pkgs.fetchurl {
      url = "https://git.kdb424.xyz/kdb424/wallpapers/raw/branch/main/wallhaven-7p3we9.png";
      sha256 = "05acf2czadfnxswnqpgx9rsx71mqspmz5kafi3i1d2z191az6inf";
    };
    autoEnable = true;

    polarity = "dark";
    opacity = {
      applications = 1.0;
      desktop = 1.0;
      popups = 0.8;
      terminal = 0.65;
    };
    fonts.sizes = {
      applications = 10;
      desktop = 10;
      popups = 14;
      terminal = 10;
    };

    fonts = {
      serif = {
        package = pkgs.meslo-lgs-nf;
        name = "MesloLGS NF";
      };

      sansSerif = {
        package = pkgs.meslo-lgs-nf;
        name = "MesloLGS NF";
      };

      monospace = {
        package = pkgs.meslo-lgs-nf;
        name = "MesloLGS NF";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
