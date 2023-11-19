{pkgs, ...}: {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "kdb424";
  home.homeDirectory = "/Users/kdb424";

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
  home.enableNixpkgsReleaseCheck = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Helps with non nixOS issues
  # targets.genericLinux.enable = true;

  imports = [
    ../modules/common.nix
    ../modules/mac.nix
    ../modules/commonGUI.nix
  ];
  stylix = {
    image = pkgs.fetchurl {
      url = "https://w.wallhaven.cc/full/1p/wallhaven-1poo61.jpg";
      sha256 = "sha256-PFlo9gszKxsM73jdIP+IB6Hv+AoQlryVXxd++1oZN+c=";
    };
  };
}
