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
  colors = config.lib.stylix.colors.withHashtag;
  primaryColor = colors.base04;
  altColor = colors.base0C;
in {
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 24;
        spacing = 8;
        margin = "2px 2px 0px 2px";
        modules-left = ["hyprland/workspaces"];
        modules-center = ["hyprland/window" "gamemode"];
        modules-right = ["network" "cpu" "temperature" "memory" "disk" "pulseaudio" "battery" "tray" "clock" "privacy" "custom/notification"];

        "hyprland/window" = {
          format = "<span color='${primaryColor}'>{}</span>";
        };

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
            "urgent" = "<span color='${colors.base08}'></span>";
            "active" = "<span color='${colors.base0C}'></span>";
            "default" = "<span color='${primaryColor}'></span>";
          };
        };

        "tray"."spacing" = 2;

        "clock" = {
          format = "<span color='${primaryColor}'> {:%R} </span>";
          "format-alt" = "<span color='${primaryColor}'> {:%a, %b %d, %Y %R} </span>";
          "tooltip-format" = "<tt><small>{calendar}</small></tt>";
          "calendar" = {
            "mode" = "year";
            "mode-mon-col" = 3;
            "weeks-pos" = "right";
            "on-scroll" = 1;
            "on-click-right" = "mode";
            "format" = {
              "months" = "<span color='${colors.base0D}'><b>{}</b></span>";
              "days" = "<span color='${colors.base05}'><b>{}</b></span>";
              "weeks" = "<span color='${colors.base03}'><b>W{}</b></span>";
              "weekdays" = "<span color='${colors.base05}'><b>{}</b></span>";
              "today" = "<span color='${primaryColor}'><b><u>{}</u></b></span>";
            };
          };
          "actions" = {
            "on-click-right" = "mode";
            "on-scroll-up" = "shift_up";
            "on-scroll-down" = "shift_down";
          };
        };

        "cpu" = {
          "interval" = 2;
          "format" = "<span color='${altColor}'>{usage}%  {avg_frequency}GHz</span>";
          "on-click" = "${pkgs.alacritty}/bin/alacritty -e ${pkgs.bottom}/bin/btm";
        };

        "battery" = {
          "bat" = "BAT0";
          "states" = {
            "good" = 95;
            "warning" = 30;
            "critical" = 15;
          };
          "format" = "<span color='${primaryColor}'>{capacity}% </span>{icon}";
          "format-full" = "";
          "format-icons" = [
            "<span color='${colors.base08}'></span>"
            "<span color='${colors.base09}'></span>"
            "<span color='${colors.base09}'></span>"
            "<span color='${primaryColor}'></span>"
            "<span color='${primaryColor}'></span>"
          ];
        };

        "memory" = {
          "format" = "<span color='${altColor}'>{used:0.1f}G/{total:0.1f}G </span>";
          "on-click" = "${pkgs.alacritty}/bin/alacritty -e ${pkgs.bottom}/bin/btm";
        };

        "disk" = {
          "format" = "<span color='${primaryColor}'>{used}/{total} </span>";
          "path" = "/";
        };

        "network" = {
          "interface" = "${networkInterface.eth}";
          "interval" = 2;
          "format-ethernet" = "<span color='${primaryColor}'>Up: {bandwidthUpBits} Down: {bandwidthDownBits} </span>";
          "tooltip-format-ethernet" = "<span color='${primaryColor}'>{ifname} </span>";
          "format-wifi" = "<span color='${primaryColor}'>Up: {bandwidthUpBits} Down: {bandwidthDownBits} {essid} ({signalStrength}%) </span>";
          "tooltip-format-wifi" = "<span color='${primaryColor}'>{ifname} {essid} ({signalStrength}%) </span>";
          "format-disconnected" = "<span color='${primaryColor}'>Disconnected ⚠</span>";
          "on-click" = "${pkgs.alacritty}/bin/alacritty -e ${pkgs.networkmanager}/bin/nmtui";
        };

        "pulseaudio" = {
          "format" = "<span color='${altColor}'>{volume}% {icon}</span>";
          "format-bluetooth" = "<span color='${altColor}'>{volume}% {icon}</span>";
          "format-muted" = "<span color='${altColor}'></span>";
          "format-icons" = {
            "headphones" = "<span color='${altColor}'></span>";
            "handsfree" = "<span color='${altColor}'></span>";
            "headset" = "<span color='${altColor}'></span>";
            "phone" = "<span color='${altColor}'></span>";
            "portable" = "<span color='${altColor}'></span>";
            "car" = "<span color='${altColor}'></span>";
            "default" = [
              "<span color='${altColor}'></span>"
              "<span color='${altColor}'></span>"
            ];
          };
          "on-click" = "${pkgs.pavucontrol}/bin/pavucontrol";
        };

        "temperature" = {
          "hwmon-path" = "${hwmon}";
          "format" = "<span color='${primaryColor}'>{}°C</span>";
          "critical-threshold" = 80;
          "on-click" = "${pkgs.alacritty}/bin/alacritty -e ${pkgs.bottom}/bin/btm";
        };

        "gamemode" = {
          "format" = "<span color='${primaryColor}'>{glyph}</span>";
          "format-alt" = "<span color='${primaryColor}'>{glyph} {count}</span>";
          "glyph" = "<span color='${primaryColor}'></span>";
          "hide-not-running" = true;
          "use-icon" = true;
          "icon-name" = "input-gaming-symbolic";
          "icon-spacing" = 4;
          "icon-size" = 20;
          "tooltip" = true;
          "tooltip-format" = "Games running: {count}";
        };

        "privacy" = {
          "icon-size" = 20;
          "icon-spacing" = 4;
          "transition-duration" = 250;
          "modules" = [
            {
              "type" = "screenshare";
              "tooltip" = true;
              "tooltip-icon-size" = 24;
            }
            {
              "type" = "audio-in";
              "tooltip" = true;
              "tooltip-icon-size" = 24;
            }
          ];
        };

        "custom/notification" = {
          "tooltip" = false;
          "format" = "{icon}  ";
          "format-icons" = {
            "notification" = "<span foreground='red'><sup></sup></span>";
            "none" = "";
            "dnd-notification" = "<span foreground='red'><sup></sup></span>";
            "dnd-none" = "";
            "inhibited-notification" = "<span foreground='red'><sup></sup></span>";
            "inhibited-none" = "";
            "dnd-inhibited-notification" = "<span foreground='red'><sup></sup></span>";
            "dnd-inhibited-none" = "";
          };
          "return-type" = "json";
          "exec-if" = "${pkgs.swaynotificationcenter}/bin/swaync-client";
          "exec" = "${pkgs.swaynotificationcenter}/bin/swaync-client -swb";
          "on-click" = "${pkgs.swaynotificationcenter}/bin/swaync-client -t -sw";
          "on-click-right" = "${pkgs.swaynotificationcenter}/bin/swaync-client -d -sw";
          "escape" = true;
        };
      };
    };
    style = ''
      window#waybar {
        border-radius: 5px;
      }
    '';
  };
}
