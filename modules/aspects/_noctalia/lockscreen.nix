{
  programs.noctalia.settings = {
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
      blurred_desktop = false;
      blur_intensity = 0.0;
      tint_intensity = 0.0;
    };

    # The widget layout the GUI writes is keyed by connector ("...@eDP-1") and
    # by absolute position on one monitor, so it stays machine-local. Off here
    # means the built-in centred login box.
    lockscreen_widgets.enabled = false;
  };
}
