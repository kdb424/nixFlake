{
  config,
  lib,
  pkgs,
  ...
}: {
  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  services.pipewire.wireplumber.enable;

  environment.systemPackages = with pkgs; [
    pipewire
  ];

  environment.etc.
  "wireplumber/main.lua.d/99-alsa-lowlatency.lua".text = ''
    alsa_monitor.rules = {
      {
        matches = {{{ "node.name", "matches", "alsa_output.usb-DENAFRIPS*" }}};
        apply_properties = {
          ["audio.format"] = "S32LE",
          ["audio.rate"] = "128000", -- for USB soundcards it should be twice your desired rate
          ["api.alsa.period-size"] = 2, -- defaults to 1024, tweak by trial-and-error
          -- ["api.alsa.disable-batch"] = true, -- generally, USB soundcards use the batch mode
        },
      },
    }
  '';
}
