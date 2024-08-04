{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./git.nix
    ./tmux.nix
    ./vim.nix
    ./zsh
  ];
  nixpkgs.config.allowUnfree = true;

  # modern cat
  programs.bat.enable = true;

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  home.packages = with pkgs;
    [
      # dotfiles
      yadm

      # builtin replacements
      bottom # even more top
      colordiff # gimme my colours
      du-dust # modern du
      eza # modern ls
      fd # way faster find
      fzf # fuzzy finding
      htop # modern top
      ripgrep # faster grep
      tealdeer # tldr, but rusty
      thefuck # Can't type? fuck
      zoxide # cd is just too slow

      # multiplexers
      tmate # here's what I see

      # misc tools
      hyperfine # benchmark
      killall # rip processes
      magic-wormhole # p2p send one off files
      neofetch # Check what system I'm on
      p7zip # gotta extract 'em all
      screen # multiplexer
      tree # I don't even know what to grep
      unzip # sometimes 7z ain't gonna cut it
      yt-dlp # yoink yt

      # tui apps
      #ncdu_2

      # networking
      gping # ping with tui
      imagemagick # wal dep
      iperf # local speed checks
      nmap # where in my network is it again...
      picocom # microcontrollers
      rsync # our files
      speedtest-cli # isp speed check
      wget # generic "gimme"

      # docs
      gnumake
      pandoc

      # Useful utils
      git-cliff # useful commit messages
      grex # regex made easy

      # nix tools
      alejandra # nix code formatter
      nix-prefetch-github
    ]
    ++ lib.optionals stdenv.isDarwin [
      coreutils # provides `dd` with --status=progress
      time # GNU time
      wifi-password
    ]
    ++ lib.optionals stdenv.isLinux [
      bandwhich # bandwidth per process monitor
      bmon # bandwidth monitor
      iftop # network top
      iotop # disk top
      iputils # provides `ping`, `ifconfig`, ...
      ispell # doom emacs
      libuuid # `uuidgen` (already pre-installed on mac)
      mkvtoolnix # the only container that matters
    ];
}
