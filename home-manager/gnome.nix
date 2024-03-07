{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    gnome.dconf-editor
    gnome.gnome-tweaks
  ];

  dconf.settings = {
    "org/gnome/mutter" = {
      experimental-features = [ "scale-monitor-framebuffer" ];
    };
    "org/gnome/desktop/wm/keybindings" = {
      move-to-monitor-left = "disabled";
      move-to-monitor-right = "disabled";
      move-to-workspace-1 = [ "<Super>1" ];
      move-to-workspace-2 = [ "<Super>2" ];
      move-to-workspace-3 = [ "<Super>3" ];
      move-to-workspace-4 = [ "<Super>4" ];
      move-to-workspace-left = [ "<Shift><Super>Left" ];
      move-to-workspace-right = [ "<Shift><Super>Right" ];
      switch-applications = "disabled";
      switch-applications-backward = "disabled";
      switch-to-workspace-left = [ "<Super>Left" ];
      switch-to-workspace-right = [ "<Super>Right" ];
      switch-windows = [ "<Alt>Tab" ];
      switch-windows-backward = [ "<Shift><Alt>Tab" ];
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
      ];
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
    "org/gnome/shell/keybindings" = {
      switch-to-application-1 = "disabled";
      switch-to-application-2 = "disabled";
      switch-to-application-3 = "disabled";
      switch-to-application-4 = "disabled";
    };
    "org/gnome/desktop/background" = {
      "picture-uri" = "file://${ ./wallpapers/fall-forest.jpg }";
      "picture-uri-dark" = "file://${ ./wallpapers/fall-forest.jpg }";
    };
    "org/gnome/desktop/screensaver" = {
      "picture-uri" = "file://${ ./wallpapers/fall-forest.jpg }";
    };
  };
}