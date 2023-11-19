{...}: {
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
}
