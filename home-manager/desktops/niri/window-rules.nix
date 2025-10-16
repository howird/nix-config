{
  programs.niri.settings.window-rules = [
    {
      matches = [
        {
          app-id = "zenity";
          title = "^.*🍅.+$";
        }
      ];
      baba-is-float = true;
    }

    {
      matches = [
        {app-id = "^.*.sameboy-wrapped.*$";}
        {app-id = "^.*SoundWireServer.*$";}
        {app-id = "^.*blueman.*$";}
        {app-id = "^.*confirm.*$";}
        {app-id = "^.*confirmreset.*$";}
        {app-id = "^.*dialog.*$";}
        {app-id = "^.*download.*$";}
        {app-id = "^.*error.*$";}
        {app-id = "^.*file_progress.*$";}
        {app-id = "^.*notification.*$";}
        {app-id = "^.*pavucontrol.*$";}
        {app-id = "^.*qBittorrent.*$";}
        {app-id = "^nm-.*$";}
        {app-id = "^xdg-desktop-portal-.*$";}
        {app-id = "com.github.finefindus.eyedropper";}
        {app-id = "org.gnome.FileRoller";}
        {app-id = "zenity";}
        {title = ".*file upload.*$";}
        {title = "^.*Confirm to replace files.*$";}
        {title = "^.*File Operation Progress.*$";}
        {title = "^.*Open File.*$";}
        {title = "^.*Picture-in-Picture.*$";}
        {title = "^.*Sharing Indicator.*$";}
        {title = "^.*Transmission.*$";}
        {title = "^.*Volume Control.*$";}
        {title = "^.*branchdialog.*$";}
        {
          app-id = "zen";
          title = "^Extension:.*$";
        }
        {
          app-id = "Zotero";
          title = "Zotero Settings";
        }
        {
          app-id = "Zotero";
          title = "^Plugins Manager.*$";
        }
        {
          app-id = "Zotero";
          title = "^.*Progress.*$";
        }
      ];
      excludes = [{title = "qBittorrent";}];
      open-floating = true;
    }

    {
      matches = [{app-id = "vlc";}];
      scroll-factor = 0.15;
    }

    {
      matches = [
        {app-id = "vlc";}
        {app-id = "task.warrior";}
        {app-id = "obsidian";}
      ];
      default-column-width = {proportion = 1.0;};
    }

    {
      matches = [{app-id = "org.gnome.Nautilus";}];
      default-column-width = {proportion = 0.5;};
    }

    {
      matches = [{app-id = "org.gnome.FileRoller";}];
      default-column-width = {fixed = 850;};
      default-window-height = {fixed = 500;};
    }

    {
      matches = [{title = ".*File Upload.*$";}];
      default-window-height = {fixed = 500;};
    }

    {
      matches = [{app-id = "^.*pavucontrol.*$";}];
      default-column-width = {fixed = 850;};
      default-window-height = {fixed = 450;};
    }
    {
      matches = [{app-id = "xwaylandvideobridge";}];
      opacity = 0.0;
      open-focused = false;
      default-column-width = {fixed = 1;};
      default-window-height = {fixed = 1;};
    }
  ];
}
