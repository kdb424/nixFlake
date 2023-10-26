{ config, lib, pkgs, inputs, outputs, ... }:

{

  environment.systemPackages = with pkgs; [
    (
      inputs.nix-doom-emacs.packages.${system}.default.override
      {
        doomPrivateDir = ./doom.d; 
      }
    )
  ];

}
