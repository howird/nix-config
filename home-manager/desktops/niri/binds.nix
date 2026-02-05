{config, ...}: {
  programs.niri.settings.binds = with config.lib.niri.actions; {
    "Mod+Shift+Slash".action = show-hotkey-overlay;
    "Mod+Escape".action = toggle-overview;

    "Mod+Q".action = close-window;
    "Super+Shift+Q".action = spawn "hyprlock";
    "Mod+Ctrl+Alt+Q".action = quit;
    "Mod+Return".action = spawn "rofi" "-show" "drun";

    "Mod+T".action = spawn "ghostty";
    "Mod+O".action = spawn "thunar";
    "Mod+B".action = spawn "zen-twilight";
    "Mod+M".action = spawn "spotify";
    "Mod+I".action = spawn "vesktop";
    "Mod+N".action = spawn "swaync-client" "-t" "-sw";
    "Mod+Shift+T".action =
      spawn
      "ghostty"
      "--class=task.warrior"
      "--title=taskwarrior"
      "-e"
      "zellij"
      "attach"
      "taskwarrior";

    "Mod+S".action.screenshot = {show-pointer = false;};
    "Mod+Ctrl+S".action.screenshot = {show-pointer = false;};
    "Mod+Shift+S".action.screenshot-window = {write-to-disk = false;};
    "Mod+Ctrl+Shift+S".action.screenshot-window = {write-to-disk = true;};

    # Window
    "Mod+H".action = focus-column-left;
    "Mod+L".action = focus-column-right;
    "Mod+Left".action = focus-column-left;
    "Mod+Right".action = focus-column-right;

    "Mod+Ctrl+H".action = move-column-left;
    "Mod+Ctrl+L".action = move-column-right;
    "Mod+Ctrl+Left".action = move-column-left;
    "Mod+Ctrl+Right".action = move-column-right;

    "Mod+Tab".action = focus-workspace-previous;
    "Mod+J".action = focus-workspace-down;
    "Mod+K".action = focus-workspace-up;
    "Mod+Ctrl+J".action = move-column-to-workspace-down;
    "Mod+Ctrl+K".action = move-column-to-workspace-up;

    "Mod+Semicolon".action = focus-window-down;
    "Mod+Shift+Semicolon".action = focus-window-up;
    "Mod+Ctrl+Semicolon".action = move-window-down;
    "Mod+Ctrl+Shift+Semicolon".action = move-window-up;

    "Mod+Comma".action = consume-window-into-column;
    "Mod+Period".action = expel-window-from-column;

    "Mod+BracketLeft".action = consume-or-expel-window-left;
    "Mod+BracketRight".action = consume-or-expel-window-right;

    # Monitor
    "Mod+Alt+H".action = focus-monitor-left;
    "Mod+Alt+J".action = focus-monitor-down;
    "Mod+Alt+K".action = focus-monitor-up;
    "Mod+Alt+L".action = focus-monitor-right;

    "Mod+Alt+Left".action = focus-monitor-left;
    "Mod+Alt+Down".action = focus-monitor-down;
    "Mod+Alt+Up".action = focus-monitor-up;
    "Mod+Alt+Right".action = focus-monitor-right;

    "Mod+Alt+Ctrl+H".action = move-workspace-to-monitor-left;
    "Mod+Alt+Ctrl+J".action = move-workspace-to-monitor-down;
    "Mod+Alt+Ctrl+K".action = move-workspace-to-monitor-up;
    "Mod+Alt+Ctrl+L".action = move-workspace-to-monitor-right;

    "Mod+Alt+Ctrl+Left".action = move-workspace-to-monitor-left;
    "Mod+Alt+Ctrl+Down".action = move-workspace-to-monitor-down;
    "Mod+Alt+Ctrl+Up".action = move-workspace-to-monitor-up;
    "Mod+Alt+Ctrl+Right".action = move-workspace-to-monitor-right;

    "Mod+Alt+Ctrl+Shift+H".action = move-column-to-monitor-left;
    "Mod+Alt+Ctrl+Shift+J".action = move-column-to-monitor-down;
    "Mod+Alt+Ctrl+Shift+K".action = move-column-to-monitor-up;
    "Mod+Alt+Ctrl+Shift+L".action = move-column-to-monitor-right;

    "Mod+Alt+Ctrl+Shift+Left".action = move-column-to-monitor-left;
    "Mod+Alt+Ctrl+Shift+Down".action = move-column-to-monitor-down;
    "Mod+Alt+Ctrl+Shift+Up".action = move-column-to-monitor-up;
    "Mod+Alt+Ctrl+Shift+Right".action = move-column-to-monitor-right;

    # Mouse wheel workspace switching
    "Mod+WheelScrollDown" = {
      action = focus-workspace-down;
      cooldown-ms = 150;
    };
    "Mod+WheelScrollUp" = {
      action = focus-workspace-up;
      cooldown-ms = 150;
    };
    "Mod+Ctrl+WheelScrollDown" = {
      action = move-column-to-workspace-down;
      cooldown-ms = 150;
    };
    "Mod+Ctrl+WheelScrollUp" = {
      action = move-column-to-workspace-up;
      cooldown-ms = 150;
    };

    "Mod+WheelScrollRight".action = focus-column-right;
    "Mod+WheelScrollLeft".action = focus-column-left;
    "Mod+Ctrl+WheelScrollRight".action = move-column-right;
    "Mod+Ctrl+WheelScrollLeft".action = move-column-left;

    "Mod+Shift+WheelScrollDown".action = focus-column-right;
    "Mod+Shift+WheelScrollUp".action = focus-column-left;
    "Mod+Ctrl+Shift+WheelScrollDown".action = move-column-right;
    "Mod+Ctrl+Shift+WheelScrollUp".action = move-column-left;

    "Mod+R".action = switch-preset-column-width;
    "Mod+Shift+R".action = switch-preset-window-height;
    "Mod+Ctrl+R".action = reset-window-height;
    "Mod+Shift+F".action = fullscreen-window;
    "Mod+F".action = maximize-column;
    "Mod+Ctrl+F".action = expand-column-to-available-width;
    "Mod+Z".action = center-column;

    "Mod+Minus".action = set-window-height "-10%";
    "Mod+Plus".action = set-window-height "+10%";
    "Mod+Equal".action = set-window-height "+10%";

    "Mod+Shift+Minus".action = set-column-width "-10%";
    "Mod+Shift+Plus".action = set-column-width "+10%";
    "Mod+Shift+Equal".action = set-column-width "+10%";

    "Mod+Space".action = toggle-window-floating;
    "Mod+W".action = toggle-column-tabbed-display;

    "Mod+V".action = spawn "voxtype" "record" "start";
    "Mod+Alt+V".action = spawn "voxtype" "record" "stop";

    # Media controls
    "XF86AudioPlay" = {
      action = spawn "playerctl" "play-pause";
      allow-when-locked = true;
    };
    "XF86AudioNext" = {
      action = spawn "playerctl" "next";
      allow-when-locked = true;
    };
    "XF86AudioPrev" = {
      action = spawn "playerctl" "previous";
      allow-when-locked = true;
    };
    "XF86AudioStop" = {
      action = spawn "playerctl" "stop";
      allow-when-locked = true;
    };
  };
}
