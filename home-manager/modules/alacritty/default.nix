{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.alacritty.enable = true;

  programs.alacritty.settings = {
    selection.save_to_clipboard = true;
    key_bindings = [
      {
        key = "Insert";
        mods = "Shift";
        action = "Paste";
      }
    ];
  };
}
