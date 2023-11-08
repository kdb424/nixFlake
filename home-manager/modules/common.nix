{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./git.nix
    ./tmux.nix
    ./vim.nix
    ./zsh
    inputs.nix-index-database.hmModules.nix-index
  ];
  nixpkgs.config.allowUnfree = true;

  # Enable nix-index
  programs.nix-index-database.comma.enable = true;

  # Enable shell integration
  programs.nix-index.enable = true;

  home.packages = with pkgs;
    [
      # Make sure ZSH is installed
      # zsh # Mac includes x86_64. Nix is always native

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
      screen # multiplexer

      # vcs
      git
      git-lfs

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
      nix-prefetch-github
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
}
