{
  programs.noctalia.settings = {
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

        start = [
          "clock"
          "uair"
        ];
        center = [
          "control-center"
          "workspaces"
          "active_window"
        ];
        end = [
          "tray"
          "notifications"
          "network"
          "bluetooth"
          "volume"
          "battery"
          "session"
        ];
      };
    };

    # Provides the `uair` widget above.
    plugins = {
      enabled = ["howird/uair"];
      source = [
        {
          name = "howird";
          kind = "path";
          location = "${../../../../configs/noctalia-plugins}";
          enabled = true;
        }
      ];
    };

    widget = {
      clock = {
        format = "it's {:%I:%M %p} on {:%a},";
        tooltip_format = "{:%A, %B %-d, %Y}";
      };
      control-center = {
        capsule = true;
        capsule_padding = 8;
      };
      uair = {
        type = "howird/uair:timer";
        label_format = "i'm {name} for {minutes} more {min_unit}";
      };
      workspaces = {
        label_source = "name";
        max_label_chars = 1;
        labels_only_when_occupied = true;

        capsule = true;
        capsule_padding = 6;
        active_pill_size = 3;
        inactive_pill_size = 1.5;

        focused_output_only = true;
        focused_color = "tertiary";
        occupied_color = "primary";
        empty_color = "primary";
        urgent_color = "secondary";
      };
      active_window = {
        max_length = 160;
        show_empty_label = true;
        title_scroll = "on_hover";
      };
    };
  };
}
