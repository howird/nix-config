{
  wayland.windowManager.hyprland.settings = {
    "$term" = "ghostty";
    "$termCls" = "com.mitchellh.$term";
    "$browser" = "zen";
    "$fileExplorer" = "nautilus";
    "$codeEditor" = "code";
    "$discordClient" = "vesktop";
    "$termExec" = "$term -e";

    "$notews" = "1";
    "$readws" = "2";
    "$creaws" = "3";

    "$watcws" = "10";
    "$filews" = "11";
    "$commws" = "12";

    bind = [
      # "$mainMod, H, workspace $taskws"
      "$mainMod, J, workspace, $notews"
      "$shftMod, J, movetoworkspace, $notews"
      "$mainMod, K, workspace, $readws"
      "$shftMod, K, movetoworkspace, $readws"
      "$mainMod, L, workspace, $creaws"
      "$shftMod, L, movetoworkspace, $creaws"
      "$mainMod, semicolon, workspace, $watcws"

      "$mainMod, E, workspace, $filews"
      "$mainMod, I, workspace, $commws"

      "$mainMod, T, exec, $term"
      "$mainMod, B, exec, $browser"
      "$mainMod, M, exec, spotify"
    ];

    # windowrulev2
    windowrulev2 = [
      # note (1)
      "workspace $notews, class:obsidian"

      # read (2)
      "group, workspace:$readws, title:Zotero"
      "workspace $readws, class:Zotero"
      "workspace $readws, class:evince"
      "workspace $readws, class:com.github.johnfactotum.Foliate"

      # create workspace (3)
      "group, workspace:$creaws, class:$termCls"
      "workspace $creaws, class:$termCls"
      "workspace $creaws, class:krita"
      "workspace $creaws, class:code"
      "workspace $creaws, class:dev.zed.Zed"

      # watch workspace (8)
      "workspace $watcws, class:mpv"
      "workspace $watcws, class:vlc"
      "workspace $watcws, class:org.gnome.Loupe"
      "workspace $watcws, class:spotify"
      "workspace $watcws, class:rhythmbox"

      # rest workspace
      "workspace 6, class:^(.*qBittorrent.*)$"

      # comms workspace (12)
      "group, workspace:$commws, class:$discordClient"
      "workspace $commws, class:$discordClient"
      "workspace $commws, class:Slack"

      # "workspace $taskws, class:$taskMgr"
    ];

    # No gaps when only
    workspace = [
      # "$taskws, on-created-empty:$taskMgr"
      "$notews, on-created-empty:obsidian"
      "$readws, on-created-empty:zotero"
      "$creaws, on-created-empty:$term"
      "$commws, on-created-empty:$discordClient"
      "$filews, on-created-empty:$fileExplorer"
    ];
  };
  programs.waybar.settings.mainBar."hyprland/workspaces".format-icons = {
    # "taskws" = "";
    "1" = "󰧑";
    "2" = "";
    "3" = "󰽉";

    "4" = "iv";
    "5" = "v";
    "6" = "vi";
    "7" = "vii";
    "8" = "viii";
    "9" = "ix";

    "10" = "";
    "11" = "";
    "12" = "";
  };
}
