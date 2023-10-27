{ config, lib, pkgs, inputs, outputs, ... }:

{

  services.zerotierone = {
    joinNetworks = [
      "4e72329aec6688e3"
    ];
    enable = true;
  
  };

}
