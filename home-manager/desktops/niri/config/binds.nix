{config, ...}: {
  programs.niri.settings.binds = with config.lib.niri.actions; {
    # Hotkey overlay
    "Mod+Shift+Slash".action = show-hotkey-overlay;

    # Screen lock
    "Super+Shift+Q" = {
      action = spawn "hyprlock";
      allow-when-locked = true;
      hotkey-overlay = {
        title = "Lock the Screen";
      };
    };

    # Application launchers
    "Mod+Return" = {
      action = spawn "rofi" "-show" "drun";
      hotkey-overlay = {
        title = "Run an Application";
      };
    };
    "Mod+T" = {
      action = spawn "ghostty";
      hotkey-overlay = {
        title = "Open Terminal";
      };
    };
    "Mod+B" = {
      action = spawn "zen";
      hotkey-overlay = {
        title = "Open Browser";
      };
    };
    "Mod+M" = {
      action = spawn "spotify";
      hotkey-overlay = {
        title = "Open Spotify";
      };
    };

    # Screenshots
    "Mod+S".action = screenshot {show-pointer = false;};
    "Mod+Shift+S".action = screenshot-window {write-to-disk = false;};
    "Mod+Ctrl+S" = {
      action = screenshot {show-pointer = false;};
      hotkey-overlay = {
        title = "Screenshot to File";
      };
    };
    "Mod+Ctrl+Shift+S".action = screenshot-window {write-to-disk = true;};

    # Audio controls
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
      action = spawn "swayosd-client" "--brightness" "+5%";
      allow-when-locked = true;
      repeat = true;
    };
    "XF86MonBrightnessDown" = {
      action = spawn "swayosd-client" "--brightness" "-5%";
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

    # Additional controls
    "Mod+N" = {
      action = spawn "swaync-client" "-t" "-sw";
      hotkey-overlay = {
        title = "Toggle Notifications";
      };
    };
    "Mod+V" = {
      action = spawn "ghostty" "--font-size=18" "-e" "clipse";
      hotkey-overlay = {
        title = "Open Clipboard";
      };
    };

    # Window management
    "Mod+Q".action = close-window;

    # Focus movement
    "Mod+H".action = focus-column-left;
    "Mod+J".action = focus-window-down;
    "Mod+K".action = focus-window-up;
    "Mod+L".action = focus-column-right;
    "Mod+Left".action = focus-column-left;
    "Mod+Down".action = focus-window-down;
    "Mod+Up".action = focus-window-up;
    "Mod+Right".action = focus-column-right;

    # Window movement
    "Mod+Ctrl+H".action = move-column-left;
    "Mod+Ctrl+J".action = move-window-down;
    "Mod+Ctrl+K".action = move-window-up;
    "Mod+Ctrl+L".action = move-column-right;
    "Mod+Ctrl+Left".action = move-column-left;
    "Mod+Ctrl+Down".action = move-window-down;
    "Mod+Ctrl+Up".action = move-window-up;
    "Mod+Ctrl+Right".action = move-column-right;

    "Mod+Home".action = focus-column-first;
    "Mod+End".action = focus-column-last;
    "Mod+Ctrl+Home".action = move-column-to-first;
    "Mod+Ctrl+End".action = move-column-to-last;

    # Monitor movement
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

    # Workspace navigation
    "Mod+U".action = focus-workspace-down;
    "Mod+I".action = focus-workspace-up;
    "Mod+Page_Down".action = focus-workspace-down;
    "Mod+Page_Up".action = focus-workspace-up;
    "Mod+Ctrl+U".action = move-column-to-workspace-down;
    "Mod+Ctrl+I".action = move-column-to-workspace-up;
    "Mod+Ctrl+Page_Down".action = move-column-to-workspace-down;
    "Mod+Ctrl+Page_Up".action = move-column-to-workspace-up;

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

    # Column/window management
    "Mod+Comma".action = consume-window-into-column;
    "Mod+Period".action = expel-window-from-column;

    "Mod+BracketLeft".action = consume-or-expel-window-left;
    "Mod+BracketRight".action = consume-or-expel-window-right;

    "Mod+R".action = switch-preset-column-width;
    "Mod+Shift+R".action = switch-preset-window-height;
    "Mod+Ctrl+R".action = reset-window-height;
    "Mod+F".action = maximize-column;
    "Mod+Shift+F".action = fullscreen-window;
    "Mod+Ctrl+F".action = expand-column-to-available-width;
    "Mod+C".action = center-column;

    # Window sizing
    "Mod+Minus".action = set-column-width "-10%";
    "Mod+Equal".action = set-column-width "+10%";
    "Mod+Shift+Minus".action = set-window-height "-10%";
    "Mod+Shift+Equal".action = set-window-height "+10%";

    # Layout controls
    "Mod+Space".action = toggle-window-floating;
    "Mod+W".action = toggle-column-tabbed-display;

    # System controls
    "Mod+Escape".action = toggle-keyboard-shortcuts-inhibit;
    "Mod+Shift+Alt+Q".action = quit;
    "Ctrl+Alt+Delete".action = quit;

    # Debug controls
    "Mod+Shift+Ctrl+T".action = toggle-debug-tint;
    "Mod+Shift+Ctrl+O".action = debug-toggle-opaque-regions;
    "Mod+Shift+Ctrl+D".action = debug-toggle-damage;
  };
}

