{
  wayland.windowManager.hyprland.settings = {
    "$term" = "ghostty";
    "$termCls" = "com.mitchellh.$term";
    "$browser" = "zen";
    "$fileManager" = "nautilus";
    "$codeEditor" = "code";
    "$discordClient" = "vesktop";
    "$termExec" = "$term -e";

    "$writws" = "1";
    "$surfws" = "2";
    "$creaws" = "3";
    "$readws" = "4";
    "$confws" = "5";
    "$watcws" = "8";
    "$filews" = "9";
    "$commws" = "10";

    bind = [
      # "$mainMod, a, workspace $taskws"
      "$mainMod, o, workspace, $writws"
      "$mainMod, b, workspace, $surfws"
      "$mainMod, t, workspace, $creaws"
      "$mainMod, e, workspace, $filews"
      "$mainMod, i, workspace, $commws"
      "$mainMod, r, workspace, $readws"
      "$shftMod, r, movetoworkspace, $readws"

      "$shftMod, T, exec, $term"
      "$shftMod, B, exec, $browser"
      "$mainMod, M, exec, spotify"
    ];

    # windowrulev2
    windowrulev2 = [
      # note (1)
      "workspace $writws, class:obsidian"

      # browse (2)
      "group, workspace:$surfws, class:$browser"

      # create workspace (3)
      "workspace $creaws, class:$termCls"
      "group, workspace:$creaws, class:$termCls"
      "workspace $creaws, class:krita"
      "workspace $creaws, class:code"
      "workspace $creaws, class:dev.zed.Zed"

      # read workspace (4)
      "group, workspace:$readws, class:Zotero"
      "workspace $readws, class:Zotero"
      "workspace $readws, class:evince"
      "workspace $readws, class:com.github.johnfactotum.Foliate"

      # watch workspace (5)
      "workspace $watcws, class:mpv"
      "workspace $watcws, class:vlc"
      "workspace $watcws, class:spotify"
      "workspace $watcws, class:rhythmbox"

      # rest workspace
      "workspace 6, class:^(.*qBittorrent.*)$"

      # special workspaces
      "workspace $commws, class:teams-for-linux"
      "workspace $commws, class:$discordClient"
      "workspace $commws, class:Slack"

      # "workspace $taskws, class:$taskMgr"
    ];

    # No gaps when only
    workspace = [
      "$writws, on-created-empty:obsidian"
      "$surfws, on-created-empty:$browser"
      "$creaws, on-created-empty:$term"
      "$readws, on-created-empty:zotero"
      "$commws, on-created-empty:$discordClient"
      "$filews, on-created-empty:$fileManager"
      # "$confws, on-created-empty:$termExec zesh cn nix/config"
      # "$taskws, on-created-empty:$taskMgr"
    ];
  };
  programs.waybar.settings.mainBar."hyprland/workspaces".format-icons = {
    "1" = "󰧑";
    "2" = "󱝆";
    "3" = "󰽉";
    "4" = "";
    "5" = "V";
    "6" = "VI";
    "7" = "VII";
    "8" = "";
    "9" = "";
    "10" = "";
    # "taskws" = "";
  };
}
