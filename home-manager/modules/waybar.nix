{
  pkgs,
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
      layer = "bottom";
      position = "top";
      height = 24;
      modules-left = ["hyprland/workspaces" "sway/mode" "wlr/taskbar"];
      modules-center = ["hyprland/window" "gamemode"];
      modules-right = ["network" "pulseaudio" "cpu" "custom/cpu_freq" "temperature" "memory" "battery" "tray" "clock"];

      "hyprland/workspaces".sort-by-number = true;

      "tray"."spacing" = 2;

      "sway/mode" = {
        format = "<span style=\"italic\">{}</span>";
      };

      "clock" = {
        format = " {:%a %b %d %R}";
      };

      "cpu" = {
        "interval" = 2;
        "format" = "{usage}%  ";
      };

      "custom/cpu_freq" = {
        format = "{}MHz ";
        interval = 5;
        exec =
          pkgs.writeShellScript "cpuFreq"
          ''
            ${pkgs.busybox}/bin/cat /proc/cpuinfo | \
            ${pkgs.busybox}/bin/grep MHz | \
            ${pkgs.busybox}/bin/cut -c 12-15 | \
            ${pkgs.busybox}/bin/tr '\n' ' ' | \
            ${pkgs.busybox}/bin/awk '{s+=$1}END{print "",s/NR}' RS=" " | \
            ${pkgs.busybox}/bin/cut -c 2-5
          '';
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

      "memory"."format" = "{used:0.1f}G/{total:0.1f}G  ";

      "network" = {
        "interface" = "${networkInterface.eth}";
        "interval" = 2;
        "format-ethernet" = "Up: {bandwidthUpBits} Down: {bandwidthDownBits}  ";
        "tooltip-format-ethernet" = "{ifname}  ";
        "format-wifi" = "Up: {bandwidthUpBits} Down: {bandwidthDownBits} {essid} ({signalStrength}%)  ";
        "tooltip-format-wifi" = "{ifname} {essid} ({signalStrength}%) ";
        "format-disconnected" = "Disconnected ⚠";
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
        "on-click" = "pavucontrol";
      };
      "temperature" = {
        "hwmon-path" = "/sys/class/hwmon/hwmon2/temp1_input";
        "format" = "{}°C";
        "critical-threshold" = 80;
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
