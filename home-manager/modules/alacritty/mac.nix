{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.alacritty.settings = {
    decorations = "none";
    # window = [
    #   {
    #     option_as_alt = "Both";
    #   }
    # ];

    # Mac rebinds
    key_bindings = [
      {
        key = "A";
        mods = "Command";
        chars = "\\x01";
      }
      {
        key = "B";
        mods = "Command";
        chars = "\\x02";
      }
      {
        key = "C";
        mods = "Command";
        chars = "\\x03";
      }
      {
        key = "D";
        mods = "Command";
        chars = "\\x04";
      }
      {
        key = "E";
        mods = "Command";
        chars = "\\x05";
      }
      {
        key = "F";
        mods = "Command";
        chars = "\\x06";
      }
      {
        key = "G";
        mods = "Command";
        chars = "\\x07";
      }
      {
        key = "H";
        mods = "Command";
        chars = "\\x08";
      }
      {
        key = "I";
        mods = "Command";
        chars = "\\x09";
      }
      {
        key = "J";
        mods = "Command";
        chars = "\\x0A";
      }
      {
        key = "K";
        mods = "Command";
        chars = "\\x0B";
      }
      {
        key = "L";
        mods = "Command";
        chars = "\\x0C";
      }
      {
        key = "M";
        mods = "Command";
        chars = "\\x0D";
      }
      {
        key = "N";
        mods = "Command";
        chars = "\\x0E";
      }
      {
        key = "O";
        mods = "Command";
        chars = "\\x0F";
      }
      {
        key = "P";
        mods = "Command";
        chars = "\\x10";
      }
      {
        key = "Q";
        mods = "Command";
        chars = "\\x11";
      }
      {
        key = "R";
        mods = "Command";
        chars = "\\x12";
      }
      {
        key = "S";
        mods = "Command";
        chars = "\\x13";
      }
      {
        key = "T";
        mods = "Command";
        chars = "\\x14";
      }
      {
        key = "U";
        mods = "Command";
        chars = "\\x15";
      }
      {
        key = "V";
        mods = "Command";
        chars = "\\x16";
      }
      {
        key = "W";
        mods = "Command";
        chars = "\\x17";
      }
      {
        key = "X";
        mods = "Command";
        chars = "\\x18";
      }
      {
        key = "Y";
        mods = "Command";
        chars = "\\x19";
      }
      {
        key = "Z";
        mods = "Command";
        chars = "\\x1A";
      }
    ];
  };
}
