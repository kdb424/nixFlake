{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.tmux = {
    enable = true;
    clock24 = true;
    mouse = true;
    keyMode = "emacs";
    sensibleOnTop = true;
    terminal = "screen-256color";
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '60' # minutes
        '';
      }
      tmuxPlugins.yank
      tmuxPlugins.extrakto
      tmuxPlugins.fpp
    ];
    extraConfig = ''
      # Fix any binds
      set -g prefix C-a
      unbind C-b
      bind-key C-a send-prefix

      unbind %
      bind | split-window -h

      unbind '"'
      bind - split-window -v

      unbind r
      bind r source-file ~/.tmux.conf

      bind -r m resize-pane -Z

      # Focus events enabled for terminals that support them
      set -g focus-events on

      # Allow the arrow key to be used immediately after changing windows
      set-option -g repeat-time 0

      # Vi parts here.
      set-window-option -g mode-keys vi
      bind-key -T copy-mode-vi 'v' send -X begin-selection # start selecting text with "v"
      bind-key -T copy-mode-vi 'y' send -X copy-selection # copy text with "y"

      # Evil escape fix
      set -s escape-time 0
    '';
  };

  programs.tmate = {
    enable = true;
    extraConfig = ''
      source-file ~/.config/tmux/tmux.conf
    '';
  };
}
