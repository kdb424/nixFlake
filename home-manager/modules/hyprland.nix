{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./waybar.nix
  ];

  services.mako = {
    enable = true;
    defaultTimeout = 4000;
  };

  wayland.windowManager.hyprland.enable = true;

  wayland.windowManager.hyprland.extraConfig = ''
    monitor=,preferred,auto,1
    exec = ${pkgs.swaybg}/bin/swaybg -i ${config.stylix.image} -m fill
    exec-once = sleep 10 && ${pkgs.swayidle}/bin/swayidle -w timeout 10 'if ${pkgs.busybox}/bin/pgrep ${pkgs.swaylock-effects}/bin/swaylock; then hyprctl dispatch dpms off; fi' resume 'hyprctl dispatch dpms on' before-sleep '${pkgs.swaylock-effects}/bin/swaylock -f'
    # Enables clipboard sync
    exec-once = ${pkgs.wl-clipboard}/bin/wl-paste -p | ${pkgs.wl-clipboard}/bin/wl-copy
    exec-once = ${pkgs.wl-clipboard}/bin/wl-paste | ${pkgs.wl-clipboard}/bin/wl-copy -p
  '';

  wayland.windowManager.hyprland.settings = {
    input = {
      sensitivity = 0.4;
      # todo custom
      accel_profile = "adaptive";
      touchpad = {
        natural_scroll = true;
        scroll_factor = 0.45;
        tap-and-drag = true;
      };
    };

    # Amy internal keyboard settings
    device.at-translated-set-2-keyboard = {
      kb_layout = "us";
      kb_variant = "dvorak";
      kb_options = ctrl:nocaps;
    };

    general = {
      gaps_in = 5;
      gaps_out = 16;
      resize_on_border = true;

      layout = "master";
    };

    master = {
      new_is_master = false;
      smart_resizing = false;
    };
    dwindle = {
      force_split = 2;
      preserve_split = true;
    };

    animations = {
      enabled = true;
      bezier = [
        "myBezier, 0.22, 1, 0.36, 1"
        "snap, 0, 1, 0, 1"
        ];

      animation = [
        "windows, 1, 0.5, myBezier"
        "windowsOut, 1, 0.5, snap, popin 80%"
        "border, 1, 0.5, snap"
        "borderangle, 1, 0.5, snap"
        "fade, 1, 0.001, myBezier"
        "workspaces, 1, 0.8, myBezier, fade"
      ];
    };
    xwayland.force_zero_scaling = true;

    # https://wiki.hyprland.org/Configuring/Variables/#gestures
    gestures = {
      workspace_swipe = true;
      workspace_swipe_fingers = 3;
      workspace_swipe_cancel_ratio = 0.01;
      workspace_swipe_distance = 2000;
      workspace_swipe_invert = true;
    };

    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      force_default_wallpaper = 0;
      mouse_move_enables_dpms = true;
      key_press_enables_dpms = true;
    };

    "$mod" = "SUPER";

    bind = [
      # general binds
      "$mod, RETURN, exec, ${pkgs.alacritty}/bin/alacritty"
      "SUPER_SHIFT, C, killactive"
      "SUPER_SHIFT, Q, exit"
      "$mod, SPACE, exec, ${pkgs.fuzzel}/bin/fuzzel"
      "SUPER_SHIFT, SPACE, togglefloating"
      "$mod, F, fullscreen"
      "$mod, L, exec, ${pkgs.swaylock-effects}/bin/swaylock -S --fade-in 1 --effect-blur 6x6"
      "$mod, B, exec, ${pkgs.grim}/bin/grim \"desktop-$(date +\"%Y%m%d%H%m\").png"
      # Screenshot selection directly to clipboard
      "SUPER_SHIFT, B, exec, ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp -d)\" - | wl-copy"

      # move focus
      "$mod, left, movefocus, l"
      "$mod, right, movefocus, r"
      "$mod, up, movefocus, u"
      "$mod, down, movefocus, d"

      # workspace switching
      "$mod, 1, workspace, 1"
      "$mod, 2, workspace, 2"
      "$mod, 3, workspace, 3"
      "$mod, 4, workspace, 4"
      "$mod, 5, workspace, 5"
      "$mod, 6, workspace, 6"
      "$mod, 7, workspace, 7"
      "$mod, 8, workspace, 8"
      "$mod, 9, workspace, 9"
      "$mod, 0, workspace, 10"

      # move window to workspace
      "$mod SHIFT, 1, movetoworkspace, 1"
      "$mod SHIFT, 2, movetoworkspace, 2"
      "$mod SHIFT, 3, movetoworkspace, 3"
      "$mod SHIFT, 4, movetoworkspace, 4"
      "$mod SHIFT, 5, movetoworkspace, 5"
      "$mod SHIFT, 6, movetoworkspace, 6"
      "$mod SHIFT, 7, movetoworkspace, 7"
      "$mod SHIFT, 8, movetoworkspace, 8"
      "$mod SHIFT, 9, movetoworkspace, 9"
      "$mod SHIFT, 0, movetoworkspace, 10"

      # Scroll through workspaces
      "$mod, mouse_down, workspace, e+1"
      "$mod, mouse_up, workspace, e-1"
    ];

    bindm = [
      # mouse movements
      "$mod, mouse:272, movewindow"
      "$mod_ALT, mouse:273, resizewindow"
      "$mod_ALT, mouse:272, resizewindow"
    ];
  };
}
