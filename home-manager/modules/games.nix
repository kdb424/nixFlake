{pkgs, ...}: {
  programs.mangohud.enable = true;

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
