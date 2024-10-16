{
  config,
  lib,
  pkgs,
  inputs,
  outputs,
  ...
}: {
  services.zerotierone = {
    joinNetworks = [
      "4e72329aec6688e3"
    ];
    enable = true;
  };

  networking.extraHosts = ''
    192.168.194.109 planex.far
    192.168.194.210 farnsworth.far
    192.168.194.24 zapp.far
    192.168.194.240 vzbot.far
    192.168.194.34 amy.far
    192.168.194.38 cubert.far
    192.168.194.200 kif.far
    192.168.194.189 morbo.far
    192.168.194.251 homeassistant.far
    192.168.194.241 grapheneos.far
    192.168.194.182 trueremote.far
    192.168.194.242 truehome.far
    192,168.194.155 yivo.far
  '';
}
