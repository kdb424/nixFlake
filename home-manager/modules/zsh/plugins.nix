{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.zsh.plugins = [
    {
      # A prompt will appear the first time to configure it properly
      # make sure to select MesloLGS NF as the font in Konsole
      name = "powerlevel10k";
      src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    }
    # {
    #   name = "zsh-vi-mode";
    #   src = pkgs.zsh-vi-mode;
    #   # file = "";
    # }
    # {
    #   name = "zsh-syntax-highlighting";
    #   src = pkgs.zsh-syntax-highlighting;
    #   # file = "";
    # }
    # {
    #   name = "zsh-fzf-tab";
    #   src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
    # }
    # {
    #   name = "zsh-fzf-history-search";
    #   src = pkgs.zsh-fzf-history-search;
    #   # file = "";
    # }
    # {
    #   name = "zsh-command-time";
    #   src = pkgs.zsh-command-time;
    #   # file = "";
    # }
    # {
    #   name = "nix-zsh-completions";
    #   src = pkgs.nix-zsh-completions;
    #   # file = "";
    # }
  ];
  programs.zsh.zplug = {
    enable = true;
    plugins = [
      {
        name = "MichaelAquilina/zsh-auto-notify";
        tags = [depth:1 from:github];
      }
      {
        name = "zpm-zsh/tmux";
        tags = [depth:1 from:github];
      }
    ];
  };
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
