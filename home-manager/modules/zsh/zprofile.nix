{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.zsh.profileExtra = ''
    if [[ $EUID != 0 ]]; then
        typeset -xT SUDO_PATH sudo_path
        typeset -U sudo_path
        sudo_path=({,/usr/local,/usr}/sbin(N-/))
        alias sudo="sudo env PATH=\"SUDO_PATH:$PATH\" "
    fi
  '';
}
