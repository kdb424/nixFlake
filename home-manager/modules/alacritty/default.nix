{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    font = {
      size = 12;
      normal.family = "MesloLGS NF";
      bold.family = "MesloLGS NF";
    };

    window.opacity = 0.65;
    key_bindings = [
      {
        key = "Insert";
        mods = "Shift";
        action = "Paste";
      }
    ];
  };
}
