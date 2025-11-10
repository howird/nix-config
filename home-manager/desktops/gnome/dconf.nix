{
  dconf.settings = {
    "org/gnome/mutter" = {
      experimental-features = ["scale-monitor-framebuffer"];
      dynamic-workspaces = false;
    };
    "org/gnome/mutter/keybindings" = {
      toggle-tiled-left = [];
      toggle-tiled-right = [];
    };
    "org/gnome/desktop/wm/preferences".num-workspaces = 10;
    "org/gnome/desktop/interface".enable-hot-corners = true;

    "org/gnome/shell" = {
      disable-user-extensions = false;
      favorite-apps = [
        "zen-twilight.desktop"
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
      switch-to-workspace-1 = ["<Super>j"];
      switch-to-workspace-2 = ["<Super>k"];
      switch-to-workspace-3 = ["<Super>l"];
      switch-to-workspace-4 = ["<Super>semicolon"];
      switch-to-workspace-left = ["<Super>Left"];
      switch-to-workspace-right = ["<Super>Right"];

      move-to-workspace-1 = ["<Shift><Super>j"];
      move-to-workspace-2 = ["<Shift><Super>k"];
      move-to-workspace-3 = ["<Shift><Super>l"];
      move-to-workspace-4 = ["<Shift><Super>semicolon"];
      move-to-workspace-left = ["<Shift><Super>Left"];
      move-to-workspace-right = ["<Shift><Super>Right"];
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
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
      ];
      screensaver = ["<Shift><Super>q"];
      home = ["<Super>o"];
      search = ["<Super>Return"];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>b";
      command = "zen-twilight";
      name = "browser";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>t";
      command = "alacritty";
      name = "terminal";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      binding = "<Super>i";
      command = "vesktop";
      name = "discord";
    };
  };
}
