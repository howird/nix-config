{
  programs.niri.settings = {
    window-rules = [
      # Global window rules
      {
        geometry-corner-radius = {
          top-left = 20.0;
          top-right = 20.0;
          bottom-left = 20.0;
          bottom-right = 20.0;
        };
        clip-to-geometry = true;
        tiled-state = true;
      }

      # Urgent window shadow
      {
        matches = [{is-urgent = true;}];
        shadow = {
          color = "#7d0d2d70";
        };
      }
    ];

    # Layout configuration
    layout = {
      # Forest green theme inspired by Hyprland config
      background-color = "#272e33";

      # Focus ring configuration
      focus-ring = {
        enable = true;
        width = 5;
        active = {
          gradient = {
            from = "#7fbbb3";
            to = "#a7c080";
            angle = 45;
            relative-to = "workspace-view";
          };
        };
        inactive = {
          color = "#859289";
        };
      };

      struts = {
        left = -5;
        right = -5;
        top = -5;
        bottom = -5;
      };

      tab-indicator = {
        enable = true;
        width = 2;
        gap = 4;
        gaps-between-tabs = 2;
        active = {
          color = "#7fbbb3";
        };
        inactive = {
          color = "#859289";
        };
      };

      # Shadow configuration
      shadow = {
        enable = true;
        softness = 20;
        spread = 3;
        color = "#272e3399";
        offset = {
          x = 0;
          y = 2;
        };
      };

      # Insert hint configuration
      insert-hint = {
        enable = true;
        display = {
          gradient = {
            from = "#7fbbb380";
            to = "#a7c08080";
            angle = 45;
            relative-to = "workspace-view";
          };
        };
      };
    };

    cursor.hide-when-typing = true;
  };
}
