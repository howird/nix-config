{config, ...}: {
  programs.niri.settings.workspaces = {
    "1".name = "make";
    "2".name = "note";
    "3".name = "read";
    "4".name = "surf";
  };

  programs.waybar.settings.mainBar."niri/workspaces".format-icons = {
    "make" = "󰽉";
    "note" = "󰧑";
    "read" = "";
    "surf" = "󱝆";
  };

  programs.niri.settings.binds = with config.lib.niri.actions; {
    "Mod+Alt+A" = {
      action = focus-workspace "make";
      allow-inhibiting = false;
    };
    "Mod+Alt+S" = {
      action = focus-workspace "note";
      allow-inhibiting = false;
    };
    "Mod+Alt+D" = {
      action = focus-workspace "read";
      allow-inhibiting = false;
    };
    "Mod+Alt+F" = {
      action = focus-workspace "surf";
      allow-inhibiting = false;
    };

    "Mod+Alt+Ctrl+A".action.move-column-to-workspace = "make";
    "Mod+Alt+Ctrl+S".action.move-column-to-workspace = "note";
    "Mod+Alt+Ctrl+D".action.move-column-to-workspace = "read";
    "Mod+Alt+Ctrl+F".action.move-column-to-workspace = "surf";
  };

  programs.niri.settings.window-rules = [
    {
      matches = [
        {
          app-id = "com.mitchellh.ghostty";
          at-startup = true;
        }
        {app-id = "code";}
        {app-id = "cursor";}
        {app-id = "dev.zed.Zed";}
        {app-id = "krita";}
        {app-id = "^jetbrains-.*$";}
      ];
      open-on-workspace = "make";
      open-focused = true;
    }

    {
      matches = [
        {
          app-id = "zenity";
          title = "^.*🍅.*$";
        }
      ];
      baba-is-float = true;
      open-on-workspace = "note";
    }

    {
      matches = [
        {app-id = "Zotero";}
        {app-id = "vlc";}
        {app-id = "org.kde.okular";}
        {app-id = "com.github.johnfactotum.Foliate";}
      ];
      open-on-workspace = "read";
      open-focused = true;
    }

    {
      matches = [
        {app-id = "md.Obsidian";}
        {
          app-id = "claude-desktop";
        }
        {app-id = "org.qbittorrent.qBittorrent";}
        {app-id = "^libreoffice-.*$";}

        {app-id = "chromium-browser";}
        {
          app-id = "^chrome-.*$";
          title = "^Fizzy.*$";
        }
      ];
      open-focused = true;
      open-on-workspace = "note";
    }

    {
      matches = [
        {
          app-id = "^chrome-.*$";
          title = "^Google Gemini.*$";
        }
        {
          app-id = "^chrome-.*$";
          title = "^Microsoft Teams.*$";
        }
        {
          app-id = "^chrome-.*$";
          title = "^Facebook Messenger.*$";
        }
        {app-id = "org.gnome.Showtime";}
        {app-id = "vesktop";}
        {app-id = "slack";}
        {app-id = "zoom";}
        {app-id = "zen-twilight";}
      ];
      open-on-workspace = "surf";
    }
  ];
}
