{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  dconf.settings = {
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
  };
}
