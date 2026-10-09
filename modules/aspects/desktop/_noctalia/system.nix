{
  programs.noctalia.settings = {
    audio = {
      enable_overdrive = false;
      enable_sounds = false;
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

    notification = {
      enable_daemon = true;
      keep_dismissed_in_history = true;
      show_actions = true;
      show_app_name = true;
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

      screenshot = {
        annotate = true;
        remember_last_region = true;
      };

      launcher = {
        categories = true;
        sort_by_usage = true;
      };
    };
  };
}
