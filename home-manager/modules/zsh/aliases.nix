{
  lib,
  pkgs,
  ...
}: let
  inherit (lib.lists) optionals;
  inherit (lib.attrsets) optionalAttrs;
  inherit (pkgs.stdenv) isLinux isDarwin;
in {
  programs.zsh.shellAliases =
    {
      diff = "${pkgs.colordiff}/bin/colordiff";
      grep = "${pkgs.ripgrep}/bin/rg";
      cat = "${pkgs.bat}/bin/bat -p";
      ls = "${pkgs.eza}/bin/eza --icons always";
      l = "${pkgs.eza}/bin/eza --icons -al";
      top = "${pkgs.bottom}/bin/btm";
      du = "${pkgs.du-dust}/bin/dust -r";
      ncdu = "${pkgs.ncdu}/bin/ncdu -x";
      cp = "cp -Riv";
      mv = "mv -iv";
      mkdir = "mkdir -pv";
      df = "df -h";
      dd = "dd status=progress bs=4M conv=fdatasync ";
      sudo = "sudo env \"PATH=$PATH\" "; # Makes sudo work with aliases and saves path
      sd = "cd $(find . -type d -print | ${pkgs.fzf}/bin/fzf)";
      # Git remote manipulation and pushing multiple remotes
      grf = "git remote set-url origin ssh://git@morbo.far:222/$(whoami)/$(basename $(pwd))";
      grh = "git remote set-url origin ssh://git@morbo.home:222/$(whoami)/$(basename $(pwd))";
      grg = "git remote set-url origin ssh://git@github.com:/$(whoami)/$(basename $(pwd))";
      gpa = "git push && git push github";
      gp = "git pull";
      gpu = "git push";
      gpf = "git push --force";
      reload = "source ~/.zshrc";
      tmux = "tmux -2";

      # Changing dirs with just dots.
      "." = "cd ../";
      ".." = "cd ../../";
      "..." = "cd ../../../";
      "...." = "cd ../../../../";

      # Misc alieses I use often
      rmd = "rm -rf";
      mine = "sudo chown -R $(whoami):users";
      nmapqsp = "sudo ${pkgs.nmap}/bin/nmap -sV -T4 -O -F --version-light";
      benchmark = "${pkgs.hyperfine}/bin/hyperfine --warmup 3 ";

      # Other
      zsnaplatest = "zfs list -t snapshot -H -S creation -o name -d 1";
      zl = "zfs list -o name,used,refer,written -r -t";
      emacsnw = "emacsclient -nw -c";
      install-doom = "git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d && ~/.emacs.d/bin/doom install";
      fhinit = "nix run \"https://flakehub.com/f/DeterminateSystems/fh/*.tar.gz\" -- init";
      sensors-where = "for m in /sys/class/hwmon/* ; do echo -n “$m = ” ; cat $m/name ; done";
    }
    // optionalAttrs isLinux {
      scrot = "${pkgs.grim}/bin/grim \"desktop-$(date +\"%Y%m%d%H%M\").png\"";
      xclip = "tee >(${pkgs.wl-clipboard}/bin/wl-copy) | ${pkgs.wl-clipboard}/bin/wl-copy -p";
    }
    // optionalAttrs isDarwin {
      xclip = "pbcopy";
      ding = "osascript -e 'display notification \"command done\"'";
    };
}
