{
  config,
  lib,
  pkgs,
  inputs,
  outputs,
  ...
}: {
  services.emacs = {
    enable = true;
    package = pkgs.emacs; # replace with emacs-gtk, or a version provided by the community overlay if desired.
  };
  environment.systemPackages = with pkgs; [
    prettier
  ];
}
