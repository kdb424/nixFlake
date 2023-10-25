{ config, lib, pkgs, inputs, outputs, ... }:

{

  # Define a user account. Don't forget to set a password with 'passwd'.
  programs.zsh.enable = true;
  users.users.kdb424 = {
    isNormalUser = true;
    description = "Kyle Brown";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      yadm
    ];
  };

}
