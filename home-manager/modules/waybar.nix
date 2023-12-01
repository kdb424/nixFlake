{
  config,
  pkgs,
  stylix,
  osConfig,
  ...
}: let
  networkInterface.eth =
    if osConfig.networking.hostName == "planex"
    then "enp2s0f0"
    else if osConfig.networking.hostName == "amy"
    then "wlp2s0"
    else "";
  hwmon =
    if osConfig.networking.hostName == "planex"
    then "/sys/class/hwmon/hwmon2/temp1_input"
    else if osConfig.networking.hostName == "amy"
    then "/sys/class/hwmon/hwmon4/temp1_input"
    else "";

in {
  programs.waybar.enable = true;

  programs.waybar.settings = {
    mainBar = {
      layer = "top";
      position = "top";
      height = 24;
      modules-left = ["hyprland/workspaces" "wlr/taskbar"];
      modules-center = ["hyprland/window" "gamemode"];
      modules-right = ["network" "pulseaudio" "disk" "cpu" "temperature" "memory" "battery" "tray" "clock"];

      "hyprland/workspaces" = {
        sort-by-number = true;
        on-click = "activate";
        format = "{icon}";
        persistent-workspaces = {
          "1" = "[]";
          "2" = "[]";
          "3" = "[]";
          "4" = "[]";
        };
        format-icons = {
          "urgent" = "";
          "active" = "";
          "default" = "";
        };
      };

      "tray"."spacing" = 2;

      "clock" = {
        format = " {:%a %b %d %R}";
      };

      "cpu" = {
        "interval" = 2;
        "format" = "{usage}%  {avg_frequency}GHz";
        "on-click" = "${pkgs.alacritty}/bin/alacritty -e ${pkgs.bottom}/bin/btm";
      };

      "battery" = {
        "bat" = "BAT0";
        "states" = {
          "good" = 95;
          "warning" = 30;
          "critical" = 15;
        };
        "format" = "{capacity}% {icon} ";
        "format-full" = "";
        "format-icons" = ["" "" "" "" ""];
      };

      "memory" = {
        "format" = "{used:0.1f}G/{total:0.1f}G  ";
        "on-click" = "${pkgs.alacritty}/bin/alacritty -e ${pkgs.bottom}/bin/btm";
      };

      "disk" = {
        "format" = "{used}/{total} ";
        "path" = "/";
      };

      "network" = {
        "interface" = "${networkInterface.eth}";
        "interval" = 2;
        "format-ethernet" = "Up: {bandwidthUpBits} Down: {bandwidthDownBits}  ";
        "tooltip-format-ethernet" = "{ifname}  ";
        "format-wifi" = "Up: {bandwidthUpBits} Down: {bandwidthDownBits} {essid} ({signalStrength}%)  ";
        "tooltip-format-wifi" = "{ifname} {essid} ({signalStrength}%) ";
        "format-disconnected" = "Disconnected ⚠";
        "on-click" = "${pkgs.alacritty}/bin/alacritty -e ${pkgs.networkmanager}/bin/nmtui";
      };

      "pulseaudio" = {
        "format" = "{volume}% {icon} ";
        "format-bluetooth" = "{volume}% {icon} ";
        "format-muted" = "";
        "format-icons" = {
          "headphones" = "";
          "handsfree" = "";
          "headset" = "";
          "phone" = "";
          "portable" = "";
          "car" = "";
          "default" = ["" ""];
        };
        "on-click" = "${pkgs.pavucontrol}/bin/pavucontrol";
      };

      "temperature" = {
        "hwmon-path" = "${hwmon}";
        "format" = "{}°C";
        "critical-threshold" = 80;
        "on-click" = "${pkgs.alacritty}/bin/alacritty -e ${pkgs.bottom}/bin/btm";
      };

      "gamemode" = {
        "format" = "{glyph}";
        "format-alt" = "{glyph} {count}";
        "glyph" = "";
        "hide-not-running" = true;
        "use-icon" = true;
        "icon-name" = "input-gaming-symbolic";
        "icon-spacing" = 4;
        "icon-size" = 20;
        "tooltip" = true;
        "tooltip-format" = "Games running: {count}";
      };
    };
  };
}
