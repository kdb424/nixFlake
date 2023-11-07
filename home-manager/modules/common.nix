{
  config,
  lib,
  pkgs,
  inputs,
  outputs,
  nix-index-database,
  ...
}: {
  home.packages = with pkgs;
    [
      # Make sure ZSH is installed
      zsh # Mac includes x86_64. Nix is always native

      # dotfiles
      yadm

      # builtin replacements
      htop # modern top
      bottom # even more top
      bat # modern cat
      colordiff # gimme my colours
      du-dust # modern du
      eza # modern ls
      fd # way faster find
      ripgrep # faster grep
      thefuck # Can't type? fuck
      zoxide # cd is just too slow
      fzf # fuzzy finding
      sd # sed, but rusty
      tealdeer # tldr, but rusty

      # multiplexers
      tmate # here's what I see

      # misc tools
      tree # I don't even know what to grep
      p7zip # gotta extract 'em all
      yt-dlp # yoink yt
      mkvtoolnix # the only container that matters
      hyperfine # benchmark
      neofetch # Check what system I'm on
      # comma # run things without installing them
      screen # multiplexer

      # vcs
      git
      git-lfs

      # editors
      #vim

      # tui apps
      #ncdu_2

      # networking
      gping # ping with TUI
      iperf # local speed checks
      nmap # where in my network is it again...
      wget # generic "gimme"
      speedtest-cli # ISP speed check
      rsync # OUR files

      imagemagick # wal dep

      picocom # microcontrollers

      # docs
      pandoc
      gnumake

      # Useful utils
      grex # regex made easy
      git-cliff # useful commit messages

      # nix tools
      comma # Command IS found I said
      nix-prefetch-github
      nix-index # needed by comma
      direnv
      nix-direnv
      cachix
      alejandra # nix code formatter
    ]
    ++ lib.optionals stdenv.isDarwin [
      coreutils # provides `dd` with --status=progress
      wifi-password
      time # GNU time
    ]
    ++ lib.optionals stdenv.isLinux [
      iputils # provides `ping`, `ifconfig`, ...
      libuuid # `uuidgen` (already pre-installed on mac)
      ispell # doom emacs
      iotop # disk top
      iftop # network top
      bandwhich # bandwidth utility
    ];

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

    '';
  };

  programs.tmate = {
    enable = true;
    extraConfig = ''
      source-file ~/.config/tmux/tmux.conf
    '';
  };

  programs.git = {
    enable = true;
    userName = "Kyle Brown";
    userEmail = "kdb424@gmail.com";
    lfs.enable = true;
    delta.enable = true;
    delta.options = {
      side-by-side = true;
    };
    ignores = [
      "*~"
      "*.swp"
    ];
    extraConfig = {
      color = {
        ui = "auto";
      };
      push = {
        autoSetupRemote = true;
      };
      pull = {
        rebase = true;
      };
      checkout = {
        workers = 8;
      };
    };
  };

  programs.vim = {
    enable = true;
    defaultEditor = true;
    extraConfig = "
      set backspace=indent,eol,start
      syntax off
      silent! colorscheme wal
    ";
    settings = {ignorecase = true;};
  };
  nixpkgs.config.allowUnfree = true;
}
