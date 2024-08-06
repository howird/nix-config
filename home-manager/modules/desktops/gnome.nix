{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  config = lib.mkIf (config.myDesktop.gnome && !config.myDesktop.kde) {
    home.packages = with pkgs; [
      dconf-editor
      gnome-tweaks

      gnome.networkmanager-openvpn
      gnome.networkmanager-openconnect

      # gnomeExtensions.user-themes
      # gnomeExtensions.tray-icons-reloaded
      # gnomeExtensions.vitals
      # gnomeExtensions.dash-to-panel
      # # gnomeExtensions.sound-output-device-chooser
      # gnomeExtensions.space-bar
    ];

    dconf.settings = {
      "org/gnome/mutter" = {
        dynamic-workspaces = true;
        experimental-features = ["scale-monitor-framebuffer"];
      };

      "org/gnome/shell" = {
        disable-user-extensions = false;
        favorite-apps = [
          "vivaldi-stable.desktop"
          "code.desktop"
          "Alacritty.desktop"
          "obsidian.desktop"
          "discord.desktop"
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

      "org/gnome/shell/app-switcher" = {
        current-workspace-only = true;
      };

      "org/gnome/desktop/wm/keybindings" = {
        switch-to-workspace-1 = ["<Super><Alt>1"];
        switch-to-workspace-2 = ["<Super><Alt>2"];
        switch-to-workspace-3 = ["<Super><Alt>3"];
        switch-to-workspace-4 = ["<Super><Alt>4"];
        switch-to-workspace-left = ["<Super>H"];
        switch-to-workspace-right = ["<Super>L"];

        move-to-workspace-1 = ["<Shift><Super>1"];
        move-to-workspace-2 = ["<Shift><Super>2"];
        move-to-workspace-3 = ["<Shift><Super>3"];
        move-to-workspace-4 = ["<Shift><Super>4"];
        move-to-workspace-left = ["<Shift><Super>H"];
        move-to-workspace-right = ["<Shift><Super>L"];
        move-to-monitor-left = "disabled";
        move-to-monitor-right = "disabled";

        switch-windows = ["<Alt>Tab"];
        switch-windows-backward = ["<Shift><Alt>Tab"];
        switch-applications = "disabled";
        switch-applications-backward = "disabled";

        toggle-fullscreen = ["<Super>f"];
        close = ["<Super>q"];
      };

      "org/gnome/shell/keybindings" = {
        show-screenshot-ui = ["<Shift><Super>s"];
        switch-to-application-1 = "disabled";
        switch-to-application-2 = "disabled";
        switch-to-application-3 = "disabled";
        switch-to-application-4 = "disabled";
        toggle-quick-settings = "disabled";
      };

      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
        ];
        logout = ["<Shift><Super>q"];
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Super>t";
        command = "alacritty";
        name = "alacritty";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
        binding = "<Super>o";
        command = "obsidian";
        name = "obsidian";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
        binding = "<Super>b";
        command = "vivaldi";
        name = "vivaldi";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
        binding = "<Super>c";
        command = "code";
        name = "code";
      };

      "org/gnome/desktop/background" = {
        "picture-uri" = "file://${config.myWallpaper}";
        "picture-uri-dark" = "file://${config.myWallpaper}";
      };

      "org/gnome/desktop/screensaver" = {
        "picture-uri" = "file://${config.myWallpaper}";
      };
    };
  };
}
