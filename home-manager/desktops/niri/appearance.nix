{config, ...}: {
  programs.niri.settings = let
    inherit (config.lib.stylix.colors.withHashtag) base00 base03 base08 base09 base0A base0B base0D;
  in {
    window-rules = [
      {
        geometry-corner-radius = {
          top-left = 20.0;
          top-right = 20.0;
          bottom-left = 20.0;
          bottom-right = 20.0;
        };
        clip-to-geometry = true;
        tiled-state = true;
        draw-border-with-background = false;
      }
      {
        matches = [{is-urgent = true;}];
        shadow = {
          color = base08;
        };
      }
    ];

    animations.enable = true;
    prefer-no-csd = true; # client-side decorations

    layout = {
      background-color = base00;
      focus-ring = {
        enable = true;
        width = 5;
        active = {
          gradient = {
            from = base0B;
            to = base0D;
            angle = 45;
            relative-to = "workspace-view";
          };
        };
      };
      border.enable = false;

      gaps = 10;
      struts = {
        left = -12;
        right = -12;
        top = -2;
        bottom = -2;
      };

      tab-indicator = {
        enable = true;
        width = 2;
        gap = 4;
        gaps-between-tabs = 2;
        active.color = base0D;
        inactive.color = base03;
      };

      shadow = {
        enable = true;
        softness = 20;
        spread = 3;
        color = base00;
        offset = {
          x = 0;
          y = 2;
        };
      };

      insert-hint = {
        enable = true;
        display = {
          gradient = {
            from = base0A;
            to = base09;
            angle = 45;
            relative-to = "workspace-view";
          };
        };
      };
    };

    cursor.hide-when-typing = true;
  };
}
