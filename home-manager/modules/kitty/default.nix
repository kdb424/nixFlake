{...}: {
  programs.kitty.enable = true;

  programs.kitty = {
    shellIntegration.enableZshIntegration
  };
}
