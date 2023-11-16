{
  config,
  lib,
  pkgs,
  ...
}: {
  services.xserver = {
    displayManager.gdm = {
      enable = false;
      wayland = true;
    };
    displayManager.lightdm.enable = false;
  };
  environment.systemPackages = with pkgs; [
    lemurs
  ];
}
