{
  config,
  lib,
  host,
  ...
}: {
  imports = [
    ./binds.nix
    ./window-rules.nix
    ./workspaces.nix
  ];

  wayland.windowManager.hyprland = {
    settings = {
      ecosystem.no_update_news = true;
      env = lib.mapAttrsToList (name: value: "${name},${value}") (import ../variables.nix);
      exec-once =
        [
          # "wl-clip-persist --clipboard both &"
          # "wl-paste --watch cliphist store &"

          "hypridle"
          "hyprpaper"

          "waybar &"
          "swaync &"

          "uair -q &"
          "start-day"
        ]
        ++ lib.optionals (host == "bofa") [
          "nm-applet &"
          "poweralertd &"
          "blueman-applet &"
        ];

      input = {
        kb_layout = "us";
        numlock_by_default = true;
        follow_mouse = 2;
        accel_profile = "flat";
        float_switch_override_focus = 0;
        sensitivity = 0;
        touchpad = {
          natural_scroll = true;
          scroll_factor = 0.25;
        };
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_distance = 50;
      };

      general = {
        layout = "master";
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        no_border_on_floating = false;
        resize_on_border = true;
      };

      misc = {
        disable_autoreload = true;
        disable_hyprland_logo = true;
        always_follow_on_dnd = true;
        layers_hog_keyboard_focus = true;
        animate_manual_resizes = false;
        enable_swallow = true;
        focus_on_activate = true;
        new_window_takes_over_fullscreen = 2;
        middle_click_paste = false;
      };

      dwindle = {
        # no_gaps_when_only = false;
        force_split = 0;
        special_scale_factor = 1.0;
        split_width_multiplier = 1.0;
        use_active_for_splits = true;
        pseudotile = "yes";
        preserve_split = "yes";
      };

      master = {
        mfact = 0.6;
        inherit_fullscreen = true;
        # no_gaps_when_only = false;
      };

      decoration = {
        rounding = 0;
        # active_opacity = 0.90;
        # inactive_opacity = 0.90;
        # fullscreen_opacity = 1.0;

        blur = {
          enabled = true;
          size = 3;
          passes = 2;
          brightness = 1;
          contrast = 1.4;
          ignore_opacity = true;
          noise = 0;
          new_optimizations = true;
          xray = true;
        };

        shadow = {
          enabled = true;

          ignore_window = true;
          offset = "0 2";
          range = 20;
          render_power = 3;
          # color = "rgba(00000055)";
        };
      };

      animations = {
        enabled = true;

        bezier = [
          "fluent_decel, 0, 0.2, 0.4, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutCubic, 0.33, 1, 0.68, 1"
          "fade_curve, 0, 0.55, 0.45, 1"
        ];

        animation = [
          # name, enable, speed, curve, style

          # Windows
          "windowsIn,   0, 4, easeOutCubic,  popin 20%" # window open
          "windowsOut,  0, 4, fluent_decel,  popin 80%" # window close.
          "windowsMove, 1, 2, fluent_decel, slide" # everything in between, moving, dragging, resizing.

          # Fade
          "fadeIn,      1, 3,   fade_curve" # fade in (open) -> layers and windows
          "fadeOut,     1, 3,   fade_curve" # fade out (close) -> layers and windows
          "fadeSwitch,  0, 1,   easeOutCirc" # fade on changing activewindow and its opacity
          "fadeShadow,  1, 10,  easeOutCirc" # fade on changing activewindow for shadows
          "fadeDim,     1, 4,   fluent_decel" # the easing of the dimming of inactive windows
          # "border,      1, 2.7, easeOutCirc"  # for animating the border's color switch speed
          # "borderangle, 1, 30,  fluent_decel, once" # for animating the border's gradient angle - styles: once (default), loop
          "workspaces,  1, 4,   easeOutCubic, fade" # styles: slide, slidevert, fade, slidefade, slidefadevert
        ];
      };

      # so hyprshot does not have border https://github.com/Gustash/Hyprshot/issues/60#issuecomment-2576391751
      layerrule = [
        "noanim, hyprpicker"
        "noanim, selection"
      ];

      workspace = [
        "w[t1], gapsout:0, gapsin:0"
        "w[tg1], gapsout:0, gapsin:0"
        "f[1], gapsout:0, gapsin:0"
      ];

      windowrulev2 = [
        # No gaps when only
        "bordersize 0, floating:0, onworkspace:w[t1]"
        "rounding 0, floating:0, onworkspace:w[t1]"
        "bordersize 0, floating:0, onworkspace:w[tg1]"
        "rounding 0, floating:0, onworkspace:w[tg1]"
        "bordersize 0, floating:0, onworkspace:f[1]"
        "rounding 0, floating:0, onworkspace:f[1]"
      ];

      group = {
        group_on_movetoworkspace = true;
        groupbar = let
          rgb = color: "rgb(${color})";
          green = rgb config.lib.stylix.colors.base0B;
          red = rgb config.lib.stylix.colors.base08;
          orange = rgb config.lib.stylix.colors.base0A;
          grey = rgb config.lib.stylix.colors.base03;
        in {
          render_titles = false;
          keep_upper_gap = false;
          indicator_height = 5;
          "col.active" = lib.mkForce green;
          "col.inactive" = lib.mkForce grey;
          "col.locked_active" = lib.mkForce red;
          "col.locked_inactive" = lib.mkForce orange;
        };
      };
    };

    extraConfig = ''
      monitor=,preferred,auto,auto

      xwayland {
        force_zero_scaling = true
      }
    '';
  };
}
