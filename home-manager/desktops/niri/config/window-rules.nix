{
  programs.niri.settings.window-rules = [
    # Global window rules
    {
      matches = [{}]; # Match all windows
      geometry-corner-radius = {
        top-left = 20.0;
        top-right = 20.0;
        bottom-left = 20.0;
        bottom-right = 20.0;
      };
      clip-to-geometry = true;
      tiled-state = true;
    }

    # Urgent window shadow
    {
      matches = [{is-urgent = true;}];
      shadow = {
        color = "#7d0d2d70";
      };
    }

    # mpv window rules
    {
      matches = [{app-id = "^mpv$";}];
      tiled-state = false;
      open-floating = true;
      default-column-width = {fixed = 1200;};
      default-window-height = {fixed = 725;};
    }

    # Zenity floating rules
    {
      matches = [
        {
          app-id = "^zenity$";
          title = "🍅";
        }
      ];
      open-floating = true;
      opacity = 0.75;
    }

    {
      matches = [
        {
          app-id = "^zenity$";
          title = "^what to do 🍅$";
        }
      ];
      open-floating = true;
      opacity = 0.75;
      open-focused = false;
    }

    {
      matches = [
        {
          app-id = "^zenity$";
          title = "^🍅: .*$";
        }
      ];
      open-floating = true;
      opacity = 0.75;
      open-focused = false;
    }

    # Workspace assignments
    {
      matches = [
        {
          at-startup = true;
          app-id = "^obsidian$";
        }
      ];
      open-on-workspace = "2";
    }

    {
      matches = [
        {
          at-startup = true;
          app-id = "^chromium-browser$";
        }
      ];
      open-on-workspace = "2";
    }

    {
      matches = [
        {
          at-startup = true;
          app-id = "^libreoffice-.*$";
        }
      ];
      open-on-workspace = "2";
    }

    {
      matches = [
        {
          at-startup = true;
          app-id = "^Zotero$";
        }
      ];
      open-on-workspace = "3";
    }

    {
      matches = [
        {
          at-startup = true;
          app-id = "^org\\.gnome\\.Papers$";
        }
      ];
      open-on-workspace = "3";
    }

    {
      matches = [
        {
          at-startup = true;
          app-id = "^com\\.github\\.johnfactotum\\.Foliate$";
        }
      ];
      open-on-workspace = "3";
    }

    {
      matches = [
        {
          at-startup = true;
          app-id = "^code$";
        }
      ];
      open-on-workspace = "4";
      default-column-width = {proportion = 0.66667;};
    }

    {
      matches = [
        {
          at-startup = true;
          app-id = "^cursor$";
        }
      ];
      open-on-workspace = "4";
      default-column-width = {proportion = 0.66667;};
    }

    {
      matches = [
        {
          at-startup = true;
          app-id = "^dev\\.zed\\.Zed$";
        }
      ];
      open-on-workspace = "4";
      default-column-width = {proportion = 0.66667;};
    }

    {
      matches = [
        {
          at-startup = true;
          app-id = "^krita$";
        }
      ];
      open-on-workspace = "4";
      default-column-width = {fixed = 1200;};
      open-maximized = true;
    }

    {
      matches = [
        {
          at-startup = true;
          app-id = "^jetbrains-.*$";
        }
      ];
      open-on-workspace = "4";
      default-column-width = {proportion = 0.66667;};
    }

    {
      matches = [
        {
          at-startup = true;
          app-id = "^.*qBittorrent.*$";
        }
      ];
      open-on-workspace = "6";
    }

    {
      matches = [
        {
          at-startup = true;
          app-id = "^mpv$";
        }
      ];
      open-on-workspace = "10";
    }

    {
      matches = [
        {
          at-startup = true;
          app-id = "^vlc$";
        }
      ];
      open-on-workspace = "10";
    }

    {
      matches = [
        {
          at-startup = true;
          app-id = "^com\\.github\\.rafostar\\.Clapper$";
        }
      ];
      open-on-workspace = "10";
    }

    {
      matches = [
        {
          at-startup = true;
          app-id = "^org\\.gnome\\.Loupe$";
        }
      ];
      open-on-workspace = "10";
    }

    {
      matches = [
        {
          at-startup = true;
          app-id = "^spotify$";
        }
      ];
      open-on-workspace = "10";
      open-floating = true;
      opacity = 0.8;
    }

    {
      matches = [
        {
          at-startup = true;
          app-id = "^rhythmbox$";
        }
      ];
      open-on-workspace = "10";
    }

    {
      matches = [
        {
          at-startup = true;
          app-id = "^zen$";
          title = ".*Zen Browser Private Browsing$";
        }
      ];
      open-on-workspace = "10";
    }

    {
      matches = [
        {
          at-startup = true;
          app-id = "^vesktop$";
        }
      ];
      open-on-workspace = "11";
      default-column-width = {proportion = 0.66667;};
    }

    {
      matches = [
        {
          at-startup = true;
          app-id = "^Slack$";
        }
      ];
      open-on-workspace = "11";
    }

    {
      matches = [
        {
          at-startup = true;
          app-id = "^zoom$";
        }
      ];
      open-on-workspace = "11";
    }

    {
      matches = [
        {
          at-startup = true;
          app-id = "^org\\.gnome\\.Nautilus$";
        }
      ];
      open-on-workspace = "12";
    }

    # Floating rules for various dialogs
    {
      matches = [{app-id = "^com\\.github\\.finefindus\\.eyedropper$";}];
      open-floating = true;
    }

    {
      matches = [{title = ".*Transmission.*$";}];
      open-floating = true;
    }

    {
      matches = [{title = ".*Volume Control.*$";}];
      open-floating = true;
    }

    {
      matches = [{title = ".*Sharing Indicator.*$";}];
      open-floating = true;
    }

    {
      matches = [
        {
          app-id = "^zen$";
          title = "^Extension:.*$";
        }
      ];
      open-floating = true;
    }

    {
      matches = [{title = ".*Picture-in-Picture.*$";}];
      open-floating = true;
      opacity = 1.0;
    }

    {
      matches = [{app-id = "^xdg-desktop-portal-.*$";}];
      open-floating = true;
    }

    {
      matches = [
        {
          app-id = "^Zotero$";
          title = ".*Progress.*$";
        }
      ];
      open-floating = true;
      opacity = 0.5;
    }

    {
      matches = [
        {
          app-id = "^Zotero$";
          title = "^Zotero Settings$";
        }
      ];
      open-floating = true;
    }

    {
      matches = [
        {
          app-id = "^Zotero$";
          title = "^Plugins Manager.*$";
        }
      ];
      open-floating = true;
    }

    {
      matches = [{app-id = "^.*qBittorrent.*$";}];
      excludes = [{title = "^qBittorrent$";}];
      open-floating = true;
    }

    {
      matches = [{app-id = "^org\\.gnome\\.FileRoller$";}];
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
      matches = [{app-id = "^nm-.*$";}];
      open-floating = true;
    }

    {
      matches = [{app-id = "^.*blueman.*$";}];
      open-floating = true;
    }

    {
      matches = [{app-id = "^.*pavucontrol.*$";}];
      open-floating = true;
      default-column-width = {fixed = 850;};
      default-window-height = {fixed = 450;};
    }

    {
      matches = [{app-id = "^.*SoundWireServer.*$";}];
      open-floating = true;
    }

    {
      matches = [{app-id = "^.*.sameboy-wrapped.*$";}];
      open-floating = true;
    }

    {
      matches = [{app-id = "^.*file_progress.*$";}];
      open-floating = true;
    }

    {
      matches = [{app-id = "^.*confirm.*$";}];
      open-floating = true;
    }

    {
      matches = [{app-id = "^.*dialog.*$";}];
      open-floating = true;
    }

    {
      matches = [{app-id = "^.*download.*$";}];
      open-floating = true;
    }

    {
      matches = [{app-id = "^.*notification.*$";}];
      open-floating = true;
    }

    {
      matches = [{app-id = "^.*error.*$";}];
      open-floating = true;
    }

    {
      matches = [{app-id = "^.*confirmreset.*$";}];
      open-floating = true;
    }

    {
      matches = [{title = ".*Open File.*$";}];
      open-floating = true;
    }

    {
      matches = [{title = ".*branchdialog.*$";}];
      open-floating = true;
    }

    {
      matches = [{title = ".*Confirm to replace files.*$";}];
      open-floating = true;
    }

    {
      matches = [{title = ".*File Operation Progress.*$";}];
      open-floating = true;
    }

    # Special rules for specific applications
    {
      matches = [{app-id = "^xwaylandvideobridge$";}];
      opacity = 0.0;
      open-focused = false;
      default-column-width = {fixed = 1;};
      default-window-height = {fixed = 1;};
    }

    {
      matches = [{app-id = "^zen$";}];
      opacity = 1.0;
    }

    {
      matches = [{app-id = "^org\\.gnome\\.Papers$";}];
      opacity = 1.0;
    }

    {
      matches = [{app-id = "^explorer\\.exe$";}];
      default-column-width = {};
      default-window-height = {};
    }
  ];
}

