{
  config,
  lib,
  pkgs,
  inputs,
  outputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    alejandra
    just
    vim
    wget
    home-manager
    yadm
  ];
}
