{...}: {
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
}
