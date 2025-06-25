{
  wayland.windowManager.hyprland.settings = {
    "$term" = "ghostty";
    "$browser" = "zen";
    "$file" = "nautilus";
    "$fileCls" = "nautilus";
    "$codeEditor" = "code";
    "$discordClient" = "vesktop";
    "$taskMgr" = "taskwarrior-tui";
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
      # note workspace (2)
      "workspace $notews, class:obsidian"

      # read workspace (3)
      # "group, workspace:$readws, class:Zotero"

      "workspace $readws, class:^(Zotero|org\.gnome\.Papers|com\.github\.johnfactotum\.Foliate)$"
      # "group barred, workspace:$readws, class:negative:^(Zotero|org\.gnome\.Papers|com\.github\.johnfactotum\.Foliate|zen)$"

      # create workspace (4)
      # "group, workspace:$creaws, class:^(.*tty)$"

      "workspace $creaws, class:^(code|krita|cursor|dev\.zed\.Zed|chromium-browser|libreoffice-*)$"
      # "group barred, workspace:$creaws, class:negative:^(code|krita|cursor|dev\.zed\.Zed|chromium-browser|libreoffice-*)$"

      # extra workspaces (5-9)
      "workspace 6, class:^(.*qBittorrent.*)$"

      # view workspace (10)
      "workspace $viewws, class:^(mpv|vlc|org\.gnome\.Loupe|spotify|rhythmbox)$"
      "workspace $viewws, class:^(zen)$, title:^(.*Zen Browser Private Browsing)$"

      # comms workspace (11)
      # "group, workspace:$commws"
      "workspace $commws, class:^($discordClient|Slack|zoom)$"

      # file workspace (12)
      # "group, workspace:$filews, class:$fileCls"
      "workspace $filews, class:$fileCls"
    ];

    # No gaps when only
    workspace = [
      "$taskws, on-created-empty:$termExec $taskMgr"
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
