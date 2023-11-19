{...}: {
  imports = [./bluetooth.nix];
  # enable's backlight switching
  programs.light.enable = true;

  # use TLP for power management
  services.tlp.enable = true;
}
