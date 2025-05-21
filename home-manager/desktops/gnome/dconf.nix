{...}: {
  dconf.settings = {
    "org/gnome/mutter" = {
      experimental-features = ["scale-monitor-framebuffer"];
      dynamic-workspaces = false;
    };
    "org/gnome/desktop/wm/preferences".num-workspaces = 10;
    "org/gnome/desktop/interface".enable-hot-corners = true;

    "org/gnome/shell" = {
      disable-user-extensions = false;
      favorite-apps = [
        "zen.desktop"
        "alacritty.desktop"
        "obsidian.desktop"
        "vesktop.desktop"
        "code.desktop"
        "org.gnome.Nautilus.desktop"
      ];
      # `gnome-extensions list` for a list
      # enabled-extensions = [
      #   "user-theme@gnome-shell-extensions.gcampax.github.com"
      #   "trayIconsReloaded@selfmade.pl"
      #   "Vitals@CoreCoding.com"
      #   "dash-to-panel@jderose9.github.com"
      #   "sound-output-device-chooser@kgshank.net"
      #   "space-bar@luchrioh"
      # ];
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      dash-max-icon-size = 24;
      dock-fixed = false;
      dock-position = "BOTTOM";
      extend-height = false;
      isolate-workspaces = true;
    };

    "org/gnome/shell/app-switcher" = {current-workspace-only = true;};
    "org/gnome/desktop/wm/keybindings" = {
      switch-to-workspace-1 = ["<Super>1"];
      switch-to-workspace-2 = ["<Super>2"];
      switch-to-workspace-3 = ["<Super>3"];
      switch-to-workspace-4 = ["<Super>T"];
      switch-to-workspace-left = ["<Super>H"];
      switch-to-workspace-right = ["<Super>L"];

      move-to-workspace-1 = ["<Shift><Super>1"];
      move-to-workspace-2 = ["<Shift><Super>2"];
      move-to-workspace-3 = ["<Shift><Super>3"];
      move-to-workspace-4 = ["<Shift><Super>4"];
      move-to-workspace-left = ["<Shift><Super>H"];
      move-to-workspace-right = ["<Shift><Super>L"];
      move-to-monitor-left = [];
      move-to-monitor-right = [];

      switch-windows = ["<Alt>Tab"];
      switch-windows-backward = ["<Shift><Alt>Tab"];
      switch-applications = [];
      switch-applications-backward = [];

      toggle-fullscreen = ["<Super>f"];
      toggle-maximized = ["<Super>space"];
      close = ["<Super>q"];
      maximize = [];
      minimize = [];
      switch-input-source = [];
      switch-input-source-backward = [];
    };

    "org/gnome/shell/keybindings" = {
      show-screenshot-ui = ["<Shift><Super>s"];
      switch-to-application-1 = [];
      switch-to-application-2 = [];
      switch-to-application-3 = [];
      switch-to-application-4 = [];
      toggle-quick-settings = [];
      toggle-overview = ["<Super>Return"];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
      ];
      screensaver = ["<Shift><Super>q"];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Shift><Super>t";
      command = "alacritty";
      name = "alacritty";
    };
  };
}
