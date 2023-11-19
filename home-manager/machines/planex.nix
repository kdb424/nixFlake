{pkgs, ...}: {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "kdb424";
  home.homeDirectory = "/home/kdb424";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Checks that home manager is in sync with release
  home.enableNixpkgsReleaseCheck = false;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ../modules/common.nix
    ../modules/commonGUI.nix
    ../modules/linuxGUI.nix
    ../modules/hyprland.nix
  ];
  stylix = {
    image = pkgs.fetchurl {
      url = "https://w.wallhaven.cc/full/6k/wallhaven-6kv1ow.png";
      sha256 = "sha256-b3EAkJpstDRm3VyJzuT7ACg6K0y2W5EMbf7qBZQBhi4=";
    };
  };
}
