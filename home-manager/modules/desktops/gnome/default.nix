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

      "org/gnome/shell/app-switcher" = {current-workspace-only = true;};

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
