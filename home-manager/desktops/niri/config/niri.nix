{
  pkgs,
  lib,
  host,
  ...
}: {
  programs.niri.settings = {

    layout = {
      center-focused-column = "on-overflow";

      preset-column-widths = [
        {proportion = 0.3;}
        {proportion = 0.5;}
        {proportion = 0.8;}
        {proportion = 1.0;}
      ];

      default-column-width = {
        proportion = 0.8;
      };
    };

    spawn-at-startup =
      [
        {argv = ["waybar"];}
        {argv = ["swaync"];}
        {argv = ["swayosd-server"];}
        {argv = ["uair" "-q"];}
        {argv = ["start-day"];}
      ]
      ++ lib.optionals (host == "bofa") [
        {argv = ["nm-applet"];}
        {argv = ["poweralertd"];}
        {argv = ["blueman-applet"];}
      ];

    xwayland-satellite = {
      enable = true;
      path = lib.getExe pkgs.xwayland-satellite-unstable;
    };

    input = {
      keyboard = {
        xkb = {
          layout = "us";
          # options = "compose:ralt,ctrl:nocaps";
        };
        repeat-delay = 500;
        repeat-rate = 30;
        numlock = true;
      };

      touchpad = {
        tap = true;
        natural-scroll = true;
        accel-speed = 0.2;
      };

      mouse = {
        accel-profile = "flat";
      };

      # focus-follows-mouse = {
      #   enable = true;
      #   max-scroll-amount = "0%";
      # };
    };

    environment = {
      #   CLUTTER_BACKEND = "wayland";
      #   DIRENV_LOG_FORMAT = "";
      #   DISABLE_QT5_COMPAT = "0";
      ELECTRON_OZONE_PLATFORM_HINT = "wayland";
      #   GDK_BACKEND = "wayland";
      #   MOZ_ENABLE_WAYLAND = "1";
      #   NIXOS_OZONE_WL = "1";
      #   QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      #   SDL_VIDEODRIVER = "wayland";
      #   SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
      #   XDG_SESSION_TYPE = "wayland";
      #   _JAVA_AWT_WM_NONEREPARENTING = "1";
      #   __GL_GSYNC_ALLOWED = "0";
      #   __GL_VRR_ALLOWED = "0";
    };

    # Animations configuration
    animations = {
      enable = true;
      # workspace-switch = {
      #   kind = {
      #     easing = {
      #       duration-ms = 250;
      #       curve = "ease-out-cubic";
      #     };
      #   };
      # };
      # overview-open-close = {
      #   kind = {
      #     spring = {
      #       damping-ratio = 1.0;
      #       stiffness = 800;
      #       epsilon = 0.0001;
      #     };
      #   };
      # };
      # window-open = {
      #   kind = {
      #     easing = {
      #       duration-ms = 250;
      #       curve = "ease-out-cubic";
      #     };
      #   };
      # };
      # window-close = {
      #   kind = {
      #     easing = {
      #       duration-ms = 250;
      #       curve = "ease-out-cubic";
      #     };
      #   };
      # };
      # horizontal-view-movement = {
      #   kind = {
      #     easing = {
      #       duration-ms = 150;
      #       curve = "ease-out-cubic";
      #     };
      #   };
      # };
      # window-movement = {
      #   kind = {
      #     easing = {
      #       duration-ms = 150;
      #       curve = "ease-out-cubic";
      #     };
      #   };
      # };
      # window-resize = {
      #   kind = {
      #     easing = {
      #       duration-ms = 150;
      #       curve = "ease-out-cubic";
      #     };
      #   };
      # };
      # config-notification-open-close = {
      #   kind = {
      #     easing = {
      #       duration-ms = 250;
      #       curve = "ease-out-cubic";
      #     };
      #   };
      # };
    };

    # Gestures configuration
    gestures = {
      # dnd-edge-view-scroll = {};
      # dnd-edge-workspace-switch = {};
      hot-corners = {
        enable = true;
      };
    };

    # overview = {
    #   workspace-shadow = {
    #     enable = true;
    #     softness = 40;
    #     spread = 10;
    #     offset = {
    #       x = 0;
    #       y = 10;
    #     };
    #     color = "#0005";
    #   };
    # };

    # Prefer no client-side decorations
    prefer-no-csd = true;

    # Layer rules
    layer-rules = [
      {
        matches = [{namespace = "^launcher$";}];
        shadow.enable = true;
      }
      {
        matches = [{namespace = "^notifications$";}];
        block-out-from = "screencast";
      }
      {
        matches = [{namespace = "^wallpaper$";}];
        place-within-backdrop = true;
      }
    ];
  };
}
