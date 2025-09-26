{
  programs.niri.settings.window-rules = [
    {
      matches = [
        {
          app-id = "zenity";
          title = "what to do 🍅";
        }
      ];
      baba-is-float = true;
    }
    {
      matches = [
        {
          app-id = "zenity";
          title = "🍅";
        }
        {
          app-id = "zenity";
          title = "what to do 🍅";
        }
        {
          app-id = "zenity";
          title = "^🍅: .*$";
        }
      ];
      open-floating = true;
      opacity = 0.75;
    }

    {
      matches = [
        {title = "^.*Transmission.*$";}
        {title = "^.*Volume Control.*$";}
        {title = "^.*Sharing Indicator.*$";}
        {app-id = "com.github.finefindus.eyedropper";}
        {
          app-id = "zen";
          title = "^Extension:.*$";
        }
        {app-id = "^xdg-desktop-portal-.*$";}
        {app-id = "^nm-.*$";}
        {app-id = "^.*blueman.*$";}
        {app-id = "^.*SoundWireServer.*$";}
        {app-id = "^.*.sameboy-wrapped.*$";}
        {
          app-id = "Zotero";
          title = "Zotero Settings";
        }
        {
          app-id = "Zotero";
          title = "^Plugins Manager.*$";
        }
        {app-id = "^.*file_progress.*$";}
        {app-id = "^.*confirm.*$";}
        {app-id = "^.*dialog.*$";}
        {app-id = "^.*download.*$";}
        {app-id = "^.*notification.*$";}
        {app-id = "^.*error.*$";}
        {app-id = "^.*confirmreset.*$";}
        {title = ".*Open File.*$";}
        {title = ".*branchdialog.*$";}
        {title = ".*Confirm to replace files.*$";}
        {title = ".*File Operation Progress.*$";}
        {app-id = "zenity";}
      ];
      open-floating = true;
    }

    {
      matches = [{title = ".*Picture-in-Picture.*$";}];
      open-floating = true;
      opacity = 1.0;
    }

    {
      matches = [
        {
          app-id = "Zotero";
          title = ".*Progress.*$";
        }
      ];
      open-floating = true;
      opacity = 0.5;
    }

    {
      matches = [{app-id = "^.*qBittorrent.*$";}];
      excludes = [{title = "qBittorrent";}];
      open-floating = true;
    }

    {
      matches = [{app-id = "org.gnome.Nautilus";}];
      default-column-width = {proportion = 0.5;};
    }

    {
      matches = [{app-id = "org.gnome.FileRoller";}];
      open-floating = true;
      default-column-width = {fixed = 850;};
      default-window-height = {fixed = 500;};
    }

    {
      matches = [{title = ".*File Upload.*$";}];
      open-floating = true;
      default-window-height = {fixed = 500;};
    }

    {
      matches = [{app-id = "^.*pavucontrol.*$";}];
      open-floating = true;
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
