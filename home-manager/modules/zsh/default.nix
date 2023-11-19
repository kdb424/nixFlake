{config, ...}: {
  imports = [
    ./zshrc.nix
    ./aliases.nix
    ./plugins.nix
    ./p10k.nix
    ./zprofile.nix
  ];
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autocd = true;

    initExtraBeforeCompInit = ''
      fpath+=(${config.home.profileDirectory}/share/zsh/site-functions)
    '';

    history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreAllDups = true;
      ignoreSpace = true; # ignore commands starting with a space
      save = 20000;
      size = 20000;
      share = true;
    };
  };
}
