{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.lists) optionals;
  inherit (lib.attrsets) optionalAttrs;
  inherit (pkgs.stdenv) isLinux isDarwin;
in {
  programs.zsh = {
    initExtra = ''
      # Let jobs continue even if shell exits
      setopt NO_HUP

      # https://zsh.sourceforge.io/Doc/Release/Expansion.html
      setopt NO_CASE_GLOB
      setopt NUMERIC_GLOB_SORT
      setopt EXTENDED_GLOB

      # Turn on command substitution in the prompt (and parameter expansion and arithmetic expansion).
      setopt promptsubst

      # Ignore duplicate in history.
      setopt hist_ignore_dups

      # Prevent record in history entry if preceding them with at least one space
      setopt hist_ignore_space

      # Nobody need flow control anymore. Troublesome feature.
      setopt noflowcontrol

      # For autocompletion of command line switches for aliases
      setopt COMPLETE_ALIASES


      # setup any-nix-shell integration
      ${pkgs.any-nix-shell}/bin/any-nix-shell zsh --info-right | source /dev/stdin

      # ZSH helper functions that are needed to load the config
      trysource() {
        # Sources file if it exists
        [[ -f $1 ]] && source $1
      }

      trypath() {
        # Adds to $PATH if exists
        [[ -e $1 ]] && path+=($1)
      }

      if (( $+commands[xbps-install] )); then
        export OS_DETECTION="void"
      elif (( $+commands[emerge] )); then
        export OS_DETECTION="gentoo"
      elif (( $+commands[pacman] )); then
        export OS_DETECTION="arch"
      elif (( $+commands[apt-get] )); then
        export OS_DETECTION="debian"
      elif (( $+commands[apk] )); then
        export OS_DETECTION=alpine
      elif [[ "$OSTYPE" == "darwin"* ]]; then
        export OS_DETECTION="mac"
      else
        export OS_DETECTION=""
      fi

      # TODO Port out and clean up

      # HM is bad at this. Handle it
      trysource ''${HOME}/.nix-profile/etc/profile.d/hm-session-vars.sh
      trysource /etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh

      # Configure completion style
      # zstyle ":completion:*:commands" rehash 1
      zstyle ':completion:*:sudo:*' environ PATH="$SUDO_PATH:$PATH"

      # If running as root and nice >0, renice to 0.
      if [ "$USER" = 'root' ] && [ "$(cut -d ' ' -f 19 /proc/$$/stat)" -gt 0 ]; then
        renice -n 0 -p "$$" && echo "# Adjusted nice level for current shell to 0."
      fi

      # key binding
      bindkey "\e[1~" beginning-of-line # Home
      bindkey "\e[4~" end-of-line # End
      bindkey "\e[5~" beginning-of-history # PageUp
      bindkey "\e[6~" end-of-history # PageDown
      bindkey '\e[H'  beginning-of-line # Home
      bindkey '\e[F'  end-of-line # End
      bindkey "\e[2~" quoted-insert # Ins
      bindkey "\e[3~" delete-char # Del
      bindkey "\e[5C" forward-word
      bindkey "\eOc" emacs-forward-word
      bindkey "\e[5D" backward-word
      bindkey "\eOd" emacs-backward-word
      bindkey "\e\e[C" forward-word
      bindkey "\e\e[D" backward-word
      bindkey "\e[Z" reverse-menu-complete # Shift+Tab
      # for non RH/Debian xterm, can't hurt for RH/Debian xterm
      bindkey "\eOH" beginning-of-line # Home
      bindkey "\eOF" end-of-line # End
      # History
      bindkey "^[[A" history-beginning-search-backward
      bindkey "^[[B" history-beginning-search-forward
      # brings back <alt> .
      bindkey -M viins '\e.' insert-last-word
      # set backspace=indent,eol,start # but for vi mode
      bindkey "^?" backward-delete-char

      [[ -f /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

      # Add local tools to PATH
      trypath ''${HOME}/.scripts
      trypath ''${HOME}/bin
      trypath ''${HOME}/.local/bin
      trypath ''${HOME}/.emacs.d/bin
      trypath ''${HOME}/.config/emacs/bin
      trypath ''${HOME}/src/klipper_estimator/target/release

      # Darwin-Nix will not set this
      trypath /nix/var/nix/profiles/default/bin
      trypath /run/current-system/sw/bin

      # Dev tools to PATH
      trypath ''${HOME}/src/circuitpython/mpy-cross
      trypath ''${HOME}/.nimble/bin
      trypath ''${HOME}/.cargo/bin
      trysource ''${HOME}/.cargo/env

      # Sets term colors, and fixes problems with SSH for pywal/wpg
      # Always leave near the end. Disabled on Mac
      if [[ "$OSTYPE" != "darwin"* ]]; then
        if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
          SESSION_TYPE=remote/ssh
        else
          case $(ps -o comm= -p $PPID) in
            sshd|*/sshd) SESSION_TYPE=remote/ssh;;
          esac
            # Only change term colors for local system
            [[ -f ''${XDG_CONFIG_HOME}/wpg/sequences ]] && command cat ''${XDG_CONFIG_HOME}/wpg/sequences
            [[ -f ''${HOME}/.cache/wal/sequences ]] && command cat ''${HOME}/.cache/wal/sequences
        fi
      fi

      if [ "$OS_DETECTION" = "mac" ]; then
        trysource ''${HOME}/.iterm2_shell_integration.zsh
        trypath ''${HOME}/Library/Python/3.10/bin
      fi

      # ALIASES that are more complex
      if [ "$OS_DETECTION" = "arch" ]; then
        ## Package Manager - pacman/yay
        if (( $+commands[yay] )); then
          alias pi='yay -S'
          alias pr='yay -R'
          alias psearch='yay -Slq | fzf --multi --preview 'yay -Si {1}' | xargs -ro yay -S'
          alias pu='yay -Syu --devel --timeupdate'
          alias oneshot='yay -S --asdeps'
          alias orphans="yay -Qtdq | yay -Rns -"
        else
          export XDG_CONFIG_HOME="''${HOME}/.config"
          MISSING_PACKAGES+=('yay')
          alias pi='sudo pacman -S'
          alias pr='sudo pacman -R'
          alias psearch='pacman -Slq | fzf --multi --preview 'sudo pacman -Si {1}' | xargs -ro sudo pacman -S'
          alias pu='sudo pacman -Syu'
          alias oneshot='sudo pacman -S --asdeps'
          alias orphans="pacman -Qtdq | sudo pacman -Rns -"
        fi
        alias mirrorupdate="sudo pacman-mirrors --geoip && sudo pacman -Syyu"
        alias etc-update="sudo pacdiff"
        alias asdep="sudo pacman -D --asdeps"
        alias explicit="sudo pacman -D --asexplicit"

      elif [ "$OS_DETECTION" = "debian" ]; then
        ## Package Manager - apt
        alias pi='sudo apt install'
        alias pr='sudo apt remove'
        alias psearch='apt search'
        alias pu='sudo apt update && sudo apt upgrade'
        alias orphans='apt autoremove'

      elif [ "$OS_DETECTION" = "gentoo" ]; then
        ## Package Manager - portage/emerge
        alias gsync='sudo emerge --sync'
        alias pi='sudo emerge -av --autounmask'
        alias oneshot='sudo emerge -av --oneshot'
        alias pu='sudo emerge --update --deep --with-bdeps=y --newuse --keep-going @world --ask'
        alias pr='sudo emerge --depclean -a'
        alias psearch='eix -r'
        alias howlong='sudo watch --color genlop -uic'
        alias etcupdate='sudo -E dispatch-conf'
        alias worldedit="sudo $EDITOR /var/lib/portage/world"

      elif [ "$OS_DETECTION" = "alpine" ]; then
        ## Package Manager - apk
        alias pi='sudo apk add'
        alias pr='sudo apk del'
        alias psearch='sudo apk search'
        alias pu='sudo apk update && sudo apk upgrade'
        alias worldedit="sudo $EDITOR /etc/apk/world"

      elif [ "$OS_DETECTION" = "void" ]; then
        ## Package Manager - void/xpbs
        alias pi='sudo xbps-install -S'
        alias prr='sudo xbps-remove -R'
        alias pr='sudo xbps-remove'
        alias psearch='sudo xbps-query -Rs'
        alias pu='sudo xbps-install -Su'
        alias orphans='sudo xpbs-remove -o'

      elif [ "$OS_DETECTION" = "mac" ]; then
        ## Package Manager - brew
        function pi {
            brew install "''${@:1}"
            brew bundle dump --force --file=$HOMEBREW_BREWFILE
        }
        function pic {
            brew install --cask "''${@:1}"
            brew bundle dump --force --file=$HOMEBREW_BREWFILE
        }
        function pr {
            brew uninstall "''${@:1}"
            brew bundle dump --force --file=$HOMEBREW_BREWFILE
        }
        function prc {
            brew uninstall cask "''${@:1}"
            brew bundle dump --force --file=$HOMEBREW_BREWFILE
        }
        alias psearch='brew search'
        alias pu='brew update && brew upgrade'
        alias orphans='brew autoremove'

      elif [ "$OS_DETECTION" = "bsd" ]; then
        ## Package Manager - freebsd
        alias pi='sudo pkg install'
        alias pr='sudo pkg remove'
        alias psearch='sudo pkg search'
        alias pu='sudo pkg update && sudo pkg upgrade'
      fi
      if (( $+commands[home-manager] )); then
        ## Package Manager - nix
        alias npsearch='nix search nixpkgs'
        alias hmc='home-manager expire-generations -7days'
        alias hm='home-manager '
        alias hsearch='nix search nixpkgs'
        alias nso='nix-store --optimise'
      fi

      function prune () {
        if (( $+commands[home-manager] )); then
          nix-collect-garbage --delete-older-than 7d
          nix-store --optimise
        fi
        if (( $+commands[nixos-rebuild] )); then
          sudo nix-collect-garbage -d
          sudo nix-store --optimise
        fi
        if command -v docker &> /dev/null; then
          docker system prune -a --volumes
        fi
        if [ "$OS_DETECTION" = "mac" ]; then
          brew cleanup
        fi
        if [ "$OS_DETECTION" = "alpine" ]; then
          sudo apk cache clean
        fi
        if [ "$OS_DETECTION" = "void" ]; then
          sudo xbps-remote -O
        fi
        if [ "$OS_DETECTION" = "gentoo" ]; then
          sudo eclean packages
          sudo eclean distfiles
          sudo eclean-kernel
        fi
        if [ "$OS_DETECTION" = "arch" ]; then
          if (( $+commands[yay] )); then
            yay -Sc
            yay -Yc
          else
            sudo pacman -Sc
          fi
        fi
        if [ "$OS_DETECTION" = "debian" ]; then
          sudo apt autoclean
        fi
      }


      # Easy extract
      extract () {
        if [ -f $1 ] ; then
            case $1 in
                  *.tar.bz2)      tar xvjf $1   ;;
                  *.tar.gz)       tar xvzf $1   ;;
              *.tar.xz)       tar xvJf $1   ;;
                  *.bz2)          bunzip2 $1    ;;
                  *.rar)          unrar x $1    ;;
                  *.gz)           gunzip $1     ;;
                  *.tar)          tar xvf $1    ;;
                  *.tbz2)         tar xvjf $1   ;;
                  *.tgz)          tar xvzf $1   ;;
              *.txz)          tar xvJf $1   ;;
                  *.rar)          unrar $1      ;;
                  *.zip)          unzip $1      ;;
                  *.Z)            uncompress $1 ;;
                  *.7z)           7z x $1       ;;
                *)           echo "don't know how to extract '$1'..." ;;
            esac
        else
            echo "'$1' is not a valid file!"
        fi
      }

      # Creates an archive from given directory
      mktar()  { tar cvf  "''${1%%/}.tar"     "''${1%%/}/"; }
      mktgz()  { tar cvzf "''${1%%/}.tar.gz"  "''${1%%/}/"; }
      mktbz()  { tar cvjf "''${1%%/}.tar.bz2" "''${1%%/}/"; }
      mkzip()  { 7z a -r  "''${1%%/}.zip"     "''${1%%/}/"; }
      mk7zip() { 7z a -r  "''${1%%/}.7z"      "''${1%%/}/"; }

      # Makes directory then moves into it
      function mkcdr {
          mkdir -p -v $1
          cd $1
      }

    '';

    envExtra = ''
      # Previously in .zshenv
      export PAGER=less
      export HOMEBREW_BREWFILE="~/.config/worldedit/$(hostname)"
      export AUTO_NOTIFY_THRESHOLD=30
      export ZPLUG_LOADFILE=$HOME/.zpackages.zsh
      typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

      # Do the initialization when the script is sourced (i.e. Initialize instantly)
      ZVM_INIT_MODE=sourcing

      # ZSH Tmux plugin settings
      TMUX_MOTD=false
      if [[ $(hostname) == "amy" ]] || [[ $(hostname) == "cubert" ]] ; then
          # Disable autostart on local machines
          TMUX_AUTOSTART=false
      fi
    '';
  };
}
