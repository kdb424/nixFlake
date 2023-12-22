{pkgs, ...}: {
  programs.mangohud.enable = true;

  home.packages = with pkgs; [
    yuzu-mainline
  ];

  # Desktop entry for steam gamescope
  xdg.desktopEntries.gamescope = {
    name = "Steam Gamescope";
    genericName = "Steam";
    exec = "steam-gamescope";
    terminal = false;
    categories = ["Application"];
    mimeType = ["text/html"];
  };
}
