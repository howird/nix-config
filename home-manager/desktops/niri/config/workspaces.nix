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
    # Workspace assignments
    # {
    #   matches = [
    #     {app-id = "^obsidian$";}
    #     {app-id = "^chromium-browser$";}
    #     {app-id = "^libreoffice-.*$";}
    #   ];
    #   open-on-workspace = "2";
    # }

    # {
    #   matches = [
    #     {app-id = "^Zotero$";}
    #     {app-id = "^org\\.gnome\\.Papers$";}
    #     {app-id = "^com\\.github\\.johnfactotum\\.Foliate$";}
    #   ];
    #   open-on-workspace = "3";
    # }

    # {
    #   matches = [
    #     {app-id = "^code$";}
    #     {app-id = "^cursor$";}
    #     {app-id = "^dev\\.zed\\.Zed$";}
    #     {app-id = "^krita$";}
    #     {app-id = "^jetbrains-.*$";}
    #   ];
    #   open-on-workspace = "4";
    # }

    # {
    #   matches = [
    #     {
    #       app-id = "^.*qBittorrent.*$";
    #     }
    #   ];
    #   open-on-workspace = "6";
    # }

    # {
    #   matches = [
    #     {app-id = "^vlc$";}
    #     {app-id = "^com\\.github\\.rafostar\\.Clapper$";}
    #     {app-id = "^org\\.gnome\\.Loupe$";}
    #     {app-id = "^rhythmbox$";}
    #   ];
    #   open-on-workspace = "10";
    # }

    # {
    #   matches = [
    #     {app-id = "^spotify$";}
    #   ];
    #   open-on-workspace = "10";
    #   open-floating = true;
    #   opacity = 0.8;
    # }

    # {
    #   matches = [
    #     {
    #       app-id = "^zen$";
    #       title = ".*Zen Browser Private Browsing$";
    #     }
    #   ];
    #   open-on-workspace = "10";
    # }

    # {
    #   matches = [
    #     {app-id = "^vesktop$";}
    #     {app-id = "^Slack$";}
    #     {app-id = "^zoom$";}
    #   ];
    #   open-on-workspace = "11";
    # }

    # {
    #   matches = [
    #     {app-id = "^org\\.gnome\\.Nautilus$";}
    #   ];
    #   open-on-workspace = "12";
    # }
  ];
}

