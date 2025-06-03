{
  wayland.windowManager.hyprland.settings = {
    "$term" = "ghostty";
    "$browser" = "zen";
    "$fileManager" = "nautilus";
    "$codeEditor" = "code";
    "$discordClient" = "vesktop";
    "$nixConf" = "$term -e tat ~/nix/config";

    bind = [
      "$shftMod, T, exec, $term"
      "$mainMod, B, exec, $browser"
      "$shftMod, E, exec, $floatCenter $fileManager"
      "$mainMod, M, exec, spotify"
      "$shftMod, Escape, exec, [workspace special:confws; float; center; size 1200 600] $term --class htop -e 'htop'"

      # "$mainMod, a, togglespecialworkspace, taskws"
      "$mainMod, t, togglespecialworkspace, codews"
      "$mainMod, e, togglespecialworkspace, filews"
      "$mainMod, i, togglespecialworkspace, commws"
      "$mainMod, Escape, togglespecialworkspace, confws"
      "$mainMod, r, togglespecialworkspace, readws"
      "$shftMod, r, movetoworkspace, special:readws"
    ];

    # windowrulev2
    windowrulev2 = [
      # workspace 󱞁 (1)
      "workspace 1, class:obsidian"

      # workspace  (3)
      "workspace 3, class:mpv"
      "workspace 3, class:vlc"
      "workspace 3, class:spotify"
      "workspace 3, class:rhythmbox"

      # workspace  (4)
      "workspace 4, class:krita"

      # rest workspace
      "workspace 6, class:^(.*qBittorrent.*)$"

      # special workspaces
      "workspace special:commws, class:teams-for-linux"
      "workspace special:commws, class:$discordClient"
      "workspace special:commws, class:Slack"

      "workspace special:codews, class:$term"
      "workspace special:codews, class:code"
      "workspace special:codews, class:^(.*zed.*)$"

      # "workspace special:taskws, class:$taskMgr"
      "workspace special:confws, class:nixconf"

      "workspace special:readws, class:Zotero"
    ];

    # No gaps when only
    workspace = [
      "1, on-created-empty:obsidian"
      "2, on-created-empty:$browser"

      # "special:taskws, on-created-empty:$taskMgr"
      "special:readws, on-created-empty:zotero"
      "special:codews, on-created-empty:$term"
      "special:confws, on-created-empty:$nixConf"
      "special:commws, on-created-empty:$discordClient"
      "special:filews, on-created-empty:$fileManager"
    ];
  };

  programs.waybar.settings.mainBar."hyprland/workspaces".format-icons = {
    "1" = "󱞁";
    "2" = "";
    "3" = "";
    "4" = "";
    "5" = "v";
    "6" = "vi";
    "7" = "vii";
    "8" = "viii";
    "9" = "ix";
    "10" = "x";
    "codews" = " ";
    "taskws" = " ";
    "confws" = " ";
    "readws" = " ";
    "commws" = " ";
    "filews" = " ";
  };
}
