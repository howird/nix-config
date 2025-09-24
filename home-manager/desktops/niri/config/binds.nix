{config, ...}: {
  programs.niri.settings.binds = with config.lib.niri.actions; {
    "Mod+Slash".action = show-hotkey-overlay;
    "Mod+Escape".action = toggle-overview;

    "Mod+Q".action = close-window;
    "Super+Shift+Q".action = spawn "hyprlock";
    "Mod+Ctrl+Alt+Q".action = quit;
    "Mod+Return".action = spawn "rofi" "-show" "drun";
    "Mod+T".action = spawn "ghostty";
    "Mod+B".action = spawn "zen";
    "Mod+M".action = spawn "spotify";
    "Mod+N".action = spawn "swaync-client" "-t" "-sw";

    "Mod+S".action = screenshot {show-pointer = false;};
    "Mod+Ctrl+S".action = screenshot {show-pointer = false;};
    "Mod+Shift+S".action = screenshot-window {write-to-disk = false;};
    "Mod+Ctrl+Shift+S".action = screenshot-window {write-to-disk = true;};

    "XF86AudioRaiseVolume" = {
      action = spawn "swayosd-client" "--output-volume" "+2" "--max-volume=100";
      allow-when-locked = true;
      repeat = true;
    };
    "XF86AudioLowerVolume" = {
      action = spawn "swayosd-client" "--output-volume" "-2";
      allow-when-locked = true;
      repeat = true;
    };
    "XF86AudioMute" = {
      action = spawn "swayosd-client" "--output-volume" "mute-toggle";
      allow-when-locked = true;
      repeat = false;
    };

    # Brightness controls
    "XF86MonBrightnessUp" = {
      action = spawn "swayosd-client" "--brightness" "raise" "5%";
      allow-when-locked = true;
      repeat = true;
    };
    "XF86MonBrightnessDown" = {
      action = spawn "swayosd-client" "--brightness" "lower" "5%";
      allow-when-locked = true;
      repeat = true;
    };

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

    # Window
    "Mod+H".action = focus-column-left;
    "Mod+L".action = focus-column-right;
    "Mod+Left".action = focus-column-left;
    "Mod+Right".action = focus-column-right;

    "Mod+Ctrl+H".action = move-column-left;
    "Mod+Ctrl+L".action = move-column-right;
    "Mod+Ctrl+Left".action = move-column-left;
    "Mod+Ctrl+Right".action = move-column-right;

    "Mod+J".action = focus-workspace-down;
    "Mod+K".action = focus-workspace-up;

    "Mod+Ctrl+J".action = move-column-to-workspace-down;
    "Mod+Ctrl+K".action = move-column-to-workspace-up;

    "Alt+J".action = focus-window-down;
    "Alt+K".action = focus-window-up;
    "Alt+Down".action = focus-window-down;
    "Alt+Up".action = focus-window-up;

    "Alt+Ctrl+J".action = move-window-down;
    "Alt+Ctrl+K".action = move-window-up;
    "Alt+Ctrl+Down".action = move-window-down;
    "Alt+Ctrl+Up".action = move-window-up;

    "Alt+Comma".action = consume-window-into-column;
    "Alt+Period".action = expel-window-from-column;

    "Alt+BracketLeft".action = consume-or-expel-window-left;
    "Alt+BracketRight".action = consume-or-expel-window-right;

    # Monitor
    "Mod+Shift+H".action = focus-monitor-left;
    "Mod+Shift+J".action = focus-monitor-down;
    "Mod+Shift+K".action = focus-monitor-up;
    "Mod+Shift+L".action = focus-monitor-right;
    "Mod+Shift+Left".action = focus-monitor-left;
    "Mod+Shift+Down".action = focus-monitor-down;
    "Mod+Shift+Up".action = focus-monitor-up;
    "Mod+Shift+Right".action = focus-monitor-right;

    "Mod+Shift+Ctrl+H".action = move-column-to-monitor-left;
    "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;
    "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;
    "Mod+Shift+Ctrl+L".action = move-column-to-monitor-right;
    "Mod+Shift+Ctrl+Left".action = move-column-to-monitor-left;
    "Mod+Shift+Ctrl+Down".action = move-column-to-monitor-down;
    "Mod+Shift+Ctrl+Up".action = move-column-to-monitor-up;
    "Mod+Shift+Ctrl+Right".action = move-column-to-monitor-right;

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

    # Numbered workspace navigation
    "Mod+1".action = focus-workspace 1;
    "Mod+2".action = focus-workspace 2;
    "Mod+3".action = focus-workspace 3;
    "Mod+4".action = focus-workspace 4;
    "Mod+5".action = focus-workspace 5;
    "Mod+6".action = focus-workspace 6;
    "Mod+7".action = focus-workspace 7;
    "Mod+8".action = focus-workspace 8;
    "Mod+9".action = focus-workspace 9;

    # Additional workspace binds
    "Mod+Tab".action = focus-workspace-previous;

    "Mod+R".action = switch-preset-column-width;
    "Mod+Shift+R".action = switch-preset-window-height;
    "Mod+Ctrl+R".action = reset-window-height;
    "Mod+F".action = fullscreen-window;
    "Mod+Shift+F".action = maximize-column;
    "Mod+Ctrl+F".action = expand-column-to-available-width;
    "Mod+Z".action = center-column;

    "Mod+Ctrl+Minus".action = set-column-width "-10%";
    "Mod+Ctrl+Plus".action = set-column-width "+10%";
    "Mod+Ctrl+Equal".action = set-column-width "+10%";
    "Mod+Ctrl+Shift+Minus".action = set-window-height "-10%";
    "Mod+Ctrl+Shift+Plus".action = set-window-height "-10%";
    "Mod+Ctrl+Shift+Equal".action = set-window-height "-10%";

    "Mod+Space".action = toggle-window-floating;
    "Mod+W".action = toggle-column-tabbed-display;
  };
}
