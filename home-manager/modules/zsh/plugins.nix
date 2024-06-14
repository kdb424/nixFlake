{pkgs, ...}: {
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
      {
        name = "zsh-users/zsh-syntax-highlighting";
        tags = [depth:1 from:github];
      }
      {
        name = "joshskidmore/zsh-fzf-history-search";
        tags = [depth:1 from:github];
      }
      {
        name = "spwhitt/nix-zsh-completions";
        tags = [depth:1 from:github];
      }
      {
        name = "jeffreytse/zsh-vi-mode";
        tags = [depth:1 from:github];
      }
      {
        name = "laggardkernel/zsh-thefuck";
        tags = [depth:1 from:github];
      }
      {
        name = "Aloxaf/fzf-tab";
        tags = [depth:1 from:github];
      }
    ];
  };
  programs.zsh.plugins = [
    {
      # A prompt will appear the first time to configure it properly
      # make sure to select MesloLGS NF as the font in Konsole
      name = "powerlevel10k";
      src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    }
  ];
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
  home.packages = with pkgs; [
    perl # needed for plugins
  ];
}
