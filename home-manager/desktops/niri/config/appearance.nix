{
  programs.niri.settings = {
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
            angle = 0;
            relative-to = "workspace-view";
          };
        };
        inactive = {
          color = "#859289";
        };
      };

      # Border configuration
      border = {
        enable = true;
        width = 5;
        active = {
          gradient = {
            from = "#7fbbb3";
            to = "#a7c080";
            angle = 0;
            relative-to = "workspace-view";
          };
        };
        inactive = {
          color = "#859289";
        };
      };

      # Tab indicator configuration
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

      # Preset column widths
      preset-column-widths = [
        {proportion = 0.3333333333333333;}
        {proportion = 0.5;}
        {proportion = 0.66667;}
        {proportion = 0.75;}
        {fixed = 1000;}
        {fixed = 1200;}
      ];

      # Default column width
      default-column-width = {
        proportion = 0.3333333333333333;
      };

      # Gaps configuration (ported from Hyprland gaps_in/gaps_out)
      gaps = 1;

      # Struts configuration (commented out in original)
      struts = {
        left = 0;
        right = 0;
        top = 0;
        bottom = 0;
      };
    };

    # Cursor configuration
    cursor = {
      size = 24;
      theme = "default";
      hide-when-typing = false;
    };
  };
}

