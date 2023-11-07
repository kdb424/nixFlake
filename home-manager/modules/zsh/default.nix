{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./aliases.nix
    ./plugins.nix
    ./p10k.nix
    ./zshrc.nix
    ./zprofile.nix
  ];
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableVteIntegration = true;

    initExtraBeforeCompInit = ''
      fpath+=(${config.home.profileDirectory}/share/zsh/site-functions)
    '';

    history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true; # ignore commands starting with a space
      save = 20000;
      size = 20000;
      share = true;
    };
  };
}
