{
  programs.niri.settings.workspaces = {
    "1".name = "task";
    "2".name = "note";
    "3".name = "read";
    "4".name = "create";
  };
  programs.waybar.settings.mainBar."niri/workspaces".format-icons = {
    "task" = "";
    "note" = "󰧑";
    "read" = "";
    "create" = "󰽉";
  };

  programs.niri.settings.window-rules = [
    {
      matches = [
        {
          app-id = "^chrome-.*$";
          title = "^.*Fizzy.*$";
        }
        {app-id = "com.rafaelmardojai.Blanket";}
        {app-id = "vesktop";}
        {app-id = "Slack";}
        {app-id = "zoom";}
        {app-id = "org.qbittorrent.qBittorrent";}
      ];
      open-focused = true;
      open-on-workspace = "task";
    }

    {
      matches = [
        {
          app-id = "zenity";
          title = "^.*🍅.*$";
        }
      ];
      baba-is-float = true;
      open-on-workspace = "task";
    }

    {
      matches = [
        {
          app-id = "zen-twilight";
          at-startup = true;
        }
        {
          app-id = "^chrome-.*$";
          title = "^.*Readwise.*$";
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
          app-id = "electron";
          title = "^.*Obsidian.*$";
        }
        {app-id = "chromium-browser";}
        {app-id = "^libreoffice-.*$";}
      ];
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
