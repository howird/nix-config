{
  wayland.windowManager.hyprland.settings = {
    "$term" = "ghostty";
    "$termCls" = "com.mitchellh.$term";
    "$browser" = "zen";
    "$file" = "nautilus";
    "$fileCls" = "nautilus";
    "$codeEditor" = "code";
    "$discordClient" = "vesktop";
    "$taskMgr" = "errands";
    "$taskCls" = "io.github.mrvladus.List";
    "$termExec" = "$term -e";

    "$taskws" = "1";
    "$notews" = "2";
    "$readws" = "3";
    "$creaws" = "4";

    "$viewws" = "10";
    "$commws" = "11";
    "$filews" = "12";

    bind = [
      "$mainMod, H, workspace, $taskws"
      "$shftMod, H, movetoworkspace, $taskws"
      "$mainMod, J, workspace, $notews"
      "$shftMod, J, movetoworkspace, $notews"
      "$mainMod, K, workspace, $readws"
      "$shftMod, K, movetoworkspace, $readws"
      "$mainMod, L, workspace, $creaws"
      "$shftMod, L, movetoworkspace, $creaws"
      "$mainMod, semicolon, workspace, $viewws"
      "$shftMod, semicolon, movetoworkspace, $viewws"

      "$mainMod, I, workspace, $commws"
      "$mainMod, O, workspace, $filews"

      "$mainMod, T, exec, $term"
      "$mainMod, B, exec, $browser"
      "$mainMod, M, exec, spotify"
    ];

    # windowrulev2
    windowrulev2 = [
      # note (1)
      "workspace $taskws, class:$taskCls"

      # note (2)
      "workspace $notews, class:obsidian"

      # read (3)
      "group, workspace:$readws, title:(.*)Zotero"
      "group lock, workspace:$readws, title:(.*)Zotero"

      "workspace $readws, class:Zotero"
      "workspace $readws, class:evince"
      "workspace $readws, class:com.github.johnfactotum.Foliate"

      "group invade, workspace:$readws, class:zen"
      "group invade, workspace:$readws, class:evince"
      "group invade, workspace:$readws, title:(.*)Zotero"
      "group invade, workspace:$readws, class:com.github.johnfactotum.Foliate"

      # create workspace (4)
      "group, workspace:$creaws, class:$termCls"
      "group lock, workspace:$creaws, class:$termCls"

      "workspace $creaws, class:code"
      "workspace $creaws, class:krita"
      "workspace $creaws, class:cursor"
      "workspace $creaws, class:dev.zed.Zed"

      "group invade, workspace:$creaws, class:code"
      "group invade, workspace:$creaws, class:krita"
      "group invade, workspace:$creaws, class:cursor"
      "group invade, workspace:$creaws, class:$termCls"
      "group invade, workspace:$creaws, class:dev.zed.Zed"

      # extra workspaces (5-9)
      "workspace 6, class:^(.*qBittorrent.*)$"

      # view workspace (10)
      "workspace $viewws, class:mpv"
      "workspace $viewws, class:vlc"
      "workspace $viewws, class:org.gnome.Loupe"
      "workspace $viewws, class:spotify"
      "workspace $viewws, class:rhythmbox"

      # comms workspace (11)
      "group, workspace:$commws, class:$discordClient"
      "workspace $commws, class:$discordClient"
      "workspace $commws, class:Slack"
      "workspace $commws, class:zoom"

      # file workspace (12)
      "group, workspace:$filews, class:$fileCls"
      "workspace $filews, class:$fileCls"
    ];

    # No gaps when only
    workspace = [
      "$taskws, on-created-empty:$taskMgr"
      "$notews, on-created-empty:obsidian"
      "$readws, on-created-empty:zotero"
      "$creaws, on-created-empty:$term"
      "$commws, on-created-empty:$discordClient"
      "$filews, on-created-empty:$file"
    ];
  };
  programs.waybar.settings.mainBar."hyprland/workspaces".format-icons = {
    "1" = "";
    "2" = "󰧑";
    "3" = "";
    "4" = "󰽉";

    "5" = "v";
    "6" = "vi";
    "7" = "vii";
    "8" = "viii";
    "9" = "ix";

    "10" = "";
    "11" = "";
    "12" = "";
  };
}
