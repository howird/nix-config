{
  config,
  lib,
  ...
}: let
  # Declared here rather than in modules/defaults.nix even though the _life
  # pomodoro scripts read it: every host includes den.aspects.niri
  # (den.schema.host.includes), so this file is loaded wherever the option is
  # read, and the names live next to the workspaces they name.
  #
  # The name doubles as the bar label: noctalia's workspaces widget can only
  # render a workspace's id or its name (`label_source`), with no per-workspace
  # icon map - so the name has to be the glyph itself.
  ws = config.desktop.workspaces;
in {
  options.desktop.workspaces = lib.mkOption {
    type = lib.types.attrsOf lib.types.str;
    default = {};
    description = "Named niri workspaces, keyed by a readable short name.";
  };

  config = {
    desktop.workspaces = {
      make = "󰽉";
      note = "󰧑";
      read = "";
      surf = "󱝆";
    };

    programs.niri.settings.workspaces = {
      "1".name = ws.make;
      "2".name = ws.note;
      "3".name = ws.read;
      "4".name = ws.surf;
    };

    # Lives here rather than in programs.nix: it names a workspace, so it needs
    # the glyph mapping above.
    programs.niri.settings.spawn-at-startup = [
      {argv = ["niri" "msg" "action" "focus-workspace" ws.note];}
    ];

    programs.niri.settings.binds = with config.lib.niri.actions; {
      "Mod+Alt+A" = {
        action = focus-workspace ws.make;
        allow-inhibiting = false;
      };
      "Mod+Alt+S" = {
        action = focus-workspace ws.note;
        allow-inhibiting = false;
      };
      "Mod+Alt+D" = {
        action = focus-workspace ws.read;
        allow-inhibiting = false;
      };
      "Mod+Alt+F" = {
        action = focus-workspace ws.surf;
        allow-inhibiting = false;
      };

      "Mod+Alt+Ctrl+A".action.move-column-to-workspace = ws.make;
      "Mod+Alt+Ctrl+S".action.move-column-to-workspace = ws.note;
      "Mod+Alt+Ctrl+D".action.move-column-to-workspace = ws.read;
      "Mod+Alt+Ctrl+F".action.move-column-to-workspace = ws.surf;
    };

    programs.niri.settings.window-rules = [
      {
        open-on-workspace = ws.make;

        open-focused = true;
        matches = [
          {
            app-id = "com.mitchellh.ghostty";
            at-startup = true;
          }
          {app-id = "claude-desktop";}
          {app-id = "code";}
          {app-id = "cursor";}
          {app-id = "dev.zed.Zed";}
          {app-id = "krita";}
          {app-id = "^jetbrains-.*$";}
        ];
      }

      {
        open-on-workspace = ws.note;

        baba-is-float = true;
        matches = [
          {
            app-id = "zenity";
            title = "^.*🍅.*$";
          }
        ];
      }

      {
        open-focused = true;
        open-on-workspace = ws.note;
        matches = [
          {app-id = "md.Obsidian";}
          {app-id = "org.qbittorrent.qBittorrent";}
          {app-id = "^libreoffice-.*$";}

          {app-id = "chromium-browser";}
          {
            app-id = "^chrome-.*$";
            title = "^Fizzy.*$";
          }
          {
            app-id = "^chrome-.*$";
            title = "^Linear.*$";
          }
        ];
      }

      {
        open-on-workspace = ws.read;

        open-focused = true;
        matches = [
          {app-id = "Zotero";}
          {app-id = "org.kde.okular";}
          {app-id = "com.github.johnfactotum.Foliate";}
        ];
      }

      {
        open-on-workspace = ws.surf;

        matches = [
          {app-id = "zen-twilight";}

          {app-id = "org.gnome.Showtime";}
          {app-id = "vlc";}

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
          {app-id = "slack";}
          {app-id = "zoom";}
        ];
      }
    ];
  };
}
