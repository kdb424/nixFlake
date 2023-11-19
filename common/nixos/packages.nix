{
  config,
  lib,
  pkgs,
  inputs,
  outputs,
  ...
}: {
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alejandra
    just
    vim
    wget
    home-manager
    git
  ];
}
