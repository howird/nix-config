{
  # Hand-written, and the only source of truth for the shell: the GUI writes
  # its own ~/.local/state/noctalia/settings.toml, which outranks this file at
  # runtime but is never read back in. So treat the GUI as a scratchpad - tweak
  # there to find a value you like, then port it here and rebuild.
  #
  # `noctalia config export` prints the whole resolved stack (this file plus
  # the state dir) if you need to diff what the GUI ended up with against what
  # nix declares.
  #
  # Keys stylix owns are deliberately absent, because defining them twice is a
  # conflict, not an override: theme.{source,custom_palette,mode},
  # shell.font_family, {dock,notification,osd}.background_opacity and
  # wallpaper.default.path all follow modules/aspects/_stylix/theme.nix. That
  # is the trade for having the shell retheme itself with the base16 scheme.
  #
  # Why these values are what they are - which timings mirror hypridle, why the
  # template renderer is off, what the bar layout is echoing - is in the commit
  # that introduced them (`git log -S` the key, or 70e34da).
  programs.noctalia.settings = {
    audio = {
      enable_overdrive = false;
      enable_sounds = false;
    };

    backdrop = {
      # Drawn behind niri's overview; see the layer-rule in ./niri.nix.
      enabled = true;
      blur_intensity = 0.5;
      tint_intensity = 0.3;
    };

    bar = {
      order = ["main"];
      main = {
        position = "bottom";
        thickness = 30;
        padding = 10;
        widget_spacing = 6;
        reserve_space = true;

        # Flush with the bottom edge, rounded only where it meets the desktop.
        margin_edge = 0;
        margin_ends = 0;
        radius = 0;
        radius_top_left = 20;
        radius_top_right = 20;
        shadow = false;

        start = ["launcher" "workspaces" "active_window"];
        center = ["uair" "clock"];
        end = [
          "privacy"
          "tray"
          "notifications"
          "network"
          "bluetooth"
          "volume"
          "brightness"
          "battery"
          "control-center"
          "session"
        ];
      };
    };

    battery.warning_threshold = 20;

    # No external monitor here speaks DDC/CI, and probing for it stalls the
    # brightness widget on startup.
    brightness.enable_ddcutil = false;

    calendar.enabled = false;
    weather.enabled = false;
    nightlight.enabled = false;
    hot_corners.enabled = false;
    dock.enabled = false;
    desktop_widgets.enabled = false;

    system.monitor.enabled = true;

    # lock at 10 minutes, screen off a minute later
    idle = {
      pre_action_fade_seconds = 2.0;
      behavior = {
        lock = {
          enabled = true;
          action = "lock";
          timeout = 600;
        };
        screen-off = {
          enabled = true;
          action = "screen_off";
          timeout = 660;
        };
      };
    };

    lockscreen = {
      enabled = true;
      blurred_desktop = true;
      blur_intensity = 0.6;
    };

    # The widget layout the GUI writes is keyed by connector ("...@eDP-1") and
    # by absolute position on one monitor, so it stays machine-local. Off here
    # means the built-in centred login box.
    lockscreen_widgets.enabled = false;

    notification = {
      enable_daemon = true;
      keep_dismissed_in_history = true;
      show_actions = true;
      show_app_name = true;
    };

    osd.position = "top_center";

    plugins = {
      enabled = ["howird/uair"];
      source = [
        {
          name = "howird";
          kind = "path";
          location = "${../../../configs/noctalia-plugins}";
          enabled = true;
        }
      ];
    };

    shell = {
      clipboard_enabled = true;
      polkit_agent = true;
      niri_overview_type_to_launch_enabled = true;
      settings_show_advanced = false;
      setup_wizard_enabled = false;

      date_format = "%A, %B %-d";
      time_format = "{:%I:%M %p}";

      external_ip_enabled = false;
      screen_time_enabled = false;
      telemetry_enabled = false;

      launcher = {
        categories = true;
        sort_by_usage = true;
      };

      panel = {
        clipboard_placement = "attached";
        launcher_placement = "attached";
        transparency_mode = "soft";
      };

      # niri already rounds corners; a second set from the shell doubles up.
      screen_corners.enabled = false;
    };

    # Templates write themed configs out to other apps' config dirs, which
    # stylix owns here - and they would be clobbered on every rebuild anyway.
    theme.templates = {
      enable_builtin_templates = false;
      enable_community_templates = false;
    };

    wallpaper = {
      enabled = true;
      fill_mode = "crop";
      automation.enabled = false;
    };

    widget = {
      clock = {
        format = "{:%I:%M %p} on {:%A}";
        tooltip_format = "{:%A, %B %-d, %Y}";
      };
      uair = {
        type = "howird/uair:timer";
        label_format = "{name} for {minutes} more {min_unit}, at";
      };
      workspaces = {
        label_source = "name";
        max_label_chars = 1;

        capsule = true;
        capsule_padding = 8;
        active_pill_size = 3;
        inactive_pill_size = 1.5;

        focused_color = "tertiary";
        occupied_color = "primary";
        empty_color = "primary";
        urgent_color = "secondary";
      };
    };
  };
}
