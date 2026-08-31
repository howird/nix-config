{
  programs.niri.settings.workspaces = {
    "1".name = "create";
    "2".name = "read";
    "3".name = "note";
  };
  programs.waybar.settings.mainBar."niri/workspaces".format-icons = {
    "create" = "󰽉";
    "read" = "";
    "note" = "󰧑";
  };

  programs.niri.settings.window-rules = [
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
        {
          app-id = "zen-twilight";
          at-startup = true;
        }
        {app-id = "Zotero";}
      ];
      open-on-workspace = "read";
    }

    {
      matches = [
        {app-id = "vlc";}
        {app-id = "org.kde.okular";}
        {app-id = "com.github.johnfactotum.Foliate";}
      ];
      open-on-workspace = "read";
      open-focused = true;
    }

    {
      matches = [
        {app-id = "obsidian";}
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
        {app-id = "vesktop";}
        {app-id = "Slack";}
        {app-id = "zoom";}
      ];
      open-focused = true;
      open-on-workspace = "note";
    }

    {
      matches = [
        {
          app-id = "com.mitchellh.ghostty";
          at-startup = true;
        }
      ];
      open-on-workspace = "create";
    }

    {
      matches = [
        {app-id = "code";}
        {app-id = "cursor";}
        {app-id = "dev.zed.Zed";}
        {app-id = "krita";}
        {app-id = "^jetbrains-.*$";}
      ];
      open-on-workspace = "create";
      open-focused = true;
    }
  ];
}
