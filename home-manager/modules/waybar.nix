{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.waybar.enable = true;

  programs.waybar.settings = {
    mainBar = {
      layer = "bottom";
      position = "top";
      height = 24;
      modules-left = ["hyprland/workspaces" "sway/mode" "wlr/taskbar"];
      modules-center = ["hyprland/window"];
      modules-right = ["network" "pulseaudio" "cpu" "custom/cpu_freq" "temperature" "memory" "battery" "tray" "clock"];

      "hyprland/workspaces" = {
        disable-scroll = false;
        all-outputs = false;
      };

      "tray"."spacing" = 2;

      "sway/mode" = {
        format = "<span style=\"italic\">{}</span>";
      };

      "clock" = {
        format = "{:%a %B %d %D:%M}";
      };

      "cpu" = {
        "interval" = 2;
        "format" = "{usage}% ";
      };

      "custom/cpu_freq" = {
        format = "{}MHz";
        interval = 5;
        exec =
          pkgs.writeShellScript "cpuFreq"
          ''
            cat /proc/cpuinfo| grep MHz | cut -c 12-15 | tr '\n' ' ' | awk '{s+=$1}END{print "",s/NR}' RS=" " | cut -c 2-5
          '';
      };

      "battery" = {
        "bat" = "BAT0";
        "states" = {
          "good" = 95;
          "warning" = 30;
          "critical" = 15;
        };
        "format" = "{capacity}% {icon}";
        "format-full" = "";
        "format-icons" = ["" "" "" "" ""];
      };

      "memory"."format" = "{used:0.1f}G/{total:0.1f}G ";

      "network" = {
        "interface" = "enp2s0f0";
              "interval" = 2;
              "format-ethernet" = "Up: {bandwidthUpBits} Down: {bandwidthDownBits}  ";
              "tooltip-format-ethernet" = "{ifname}  ";
              "format-wifi" = "Up: {bandwidthUpBits} Down: {bandwidthDownBits} {essid} ({signalStrength}%)  ";
              "tooltip-format-wifi" = "{ifname} {essid} ({signalStrength}%) ";
              "format-disconnected" = "Disconnected ⚠";
      };

      "pulseaudio" = {
        "format" = "{volume}% {icon}";
        "format-bluetooth" = "{volume}% {icon}";
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
    };
  };
}