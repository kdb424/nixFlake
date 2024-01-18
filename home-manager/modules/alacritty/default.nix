{...}: {
  programs.alacritty.enable = true;

  programs.alacritty.settings = {
    selection.save_to_clipboard = true;
    keyboard.bindings = [
      {
        key = "Insert";
        mods = "Shift";
        action = "Paste";
      }
    ];
  };
}
