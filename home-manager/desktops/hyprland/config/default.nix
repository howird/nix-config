{
  lib,
  host,
  ...
}: {
  imports = [
    ./appearance.nix
    ./binds.nix
    # ./scrolling.nix
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
          "swayosd-server"
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

      general.resize_on_border = true;

      misc = {
        always_follow_on_dnd = true;
        layers_hog_keyboard_focus = true;
        animate_manual_resizes = false;
        enable_swallow = true;
        focus_on_activate = true;
        new_window_takes_over_fullscreen = 2;
      };

      dwindle = {
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

      # so hyprshot does not have border https://github.com/Gustash/Hyprshot/issues/60#issuecomment-2576391751
      layerrule = [
        "noanim, hyprpicker"
        "noanim, selection"
      ];
    };

    extraConfig = ''
      monitor=, preferred, auto, 1

      xwayland {
        force_zero_scaling = true
      }
    '';
  };
}
