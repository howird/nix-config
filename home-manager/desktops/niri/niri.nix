{
  programs.niri.settings = {
    layout = {
      # center-focused-column = "on-overflow";
      always-center-single-column = true;

      preset-column-widths = [
        {proportion = 0.3334;}
        {proportion = 0.5;}
        {proportion = 0.6666;}
      ];

      preset-window-heights = [
        {proportion = 0.3334;}
        {proportion = 0.5;}
        {proportion = 0.6666;}
        {proportion = 1.0;}
      ];

      default-column-width = {
        proportion = 0.5;
      };
    };

    gestures.hot-corners.enable = true;

    input = {
      keyboard = {
        xkb.layout = "us";
        repeat-delay = 500;
        repeat-rate = 30;
        numlock = true;
      };

      touchpad = {
        tap = true;
        natural-scroll = true;
        accel-speed = 0.1;
        scroll-factor = 0.3;
      };

      mouse = {
        accel-profile = "flat";
      };

      focus-follows-mouse = {
        enable = true;
        max-scroll-amount = "55%";
      };
    };

    environment = {
      CLUTTER_BACKEND = "wayland";
      #   DIRENV_LOG_FORMAT = "";
      #   DISABLE_QT5_COMPAT = "0";
      ELECTRON_OZONE_PLATFORM_HINT = "wayland";
      GDK_BACKEND = "wayland";
      #   MOZ_ENABLE_WAYLAND = "1";
      NIXOS_OZONE_WL = "1";
      #   QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      #   SDL_VIDEODRIVER = "wayland";
      #   SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
      XDG_SESSION_TYPE = "wayland";
      #   _JAVA_AWT_WM_NONEREPARENTING = "1";
      #   __GL_GSYNC_ALLOWED = "0";
      #   __GL_VRR_ALLOWED = "0";
    };

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
