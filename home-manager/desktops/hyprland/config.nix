{host, ...}: {
  wayland.windowManager.hyprland = {
    settings = {
      # autostart
      exec-once =
        [
          "systemctl --user import-environment &"
          "hash dbus-update-activation-environment 2>/dev/null &"
          "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &"

          # "wl-clip-persist --clipboard both &"
          # "wl-paste --type text --watch cliphist store &"
          # "wl-paste --type image --watch cliphist store &"
          "clipse -listen"
          "hyprpaper"

          "waybar &"
          "swaync &"
          "swayidle -w timeout 600 'hyprlock' &"
          # "gnome-keyring-daemon --start --components=secrets &"

          ## App auto start
          "[workspace 1 silent] zotero"
          "[workspace 2 silent] obsidian"
          "[workspace 3 silent] $browser"
          "[workspace special:taskws silent] $taskMgr $electronArgs"
          "[workspace special:termws silent] $term"
        ]
        ++ (
          if host == "bofa"
          then []
          else [
            "nm-applet &"
            "poweralertd &"
            "blueman-applet &"
            "swayidle -w before-sleep 'hyprlock' &"
            "swayidle -w timeout 1200 'systemctl hibernate' &"
          ]
        );

      input = {
        kb_layout = "us";
        numlock_by_default = true;
        follow_mouse = 2;
        accel_profile = "flat";
        float_switch_override_focus = 0;
        sensitivity = 0;
        touchpad = {
          natural_scroll = true;
          scroll_factor = 0.25;
        };
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_distance = 50;
      };

      general = {
        layout = "master";
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        border_part_of_window = false;
        no_border_on_floating = false;
        resize_on_border = true;
      };

      misc = {
        disable_autoreload = true;
        disable_hyprland_logo = true;
        always_follow_on_dnd = true;
        layers_hog_keyboard_focus = true;
        animate_manual_resizes = false;
        enable_swallow = true;
        focus_on_activate = true;
        new_window_takes_over_fullscreen = 2;
        middle_click_paste = false;
      };

      dwindle = {
        # no_gaps_when_only = false;
        force_split = 0;
        special_scale_factor = 1.0;
        split_width_multiplier = 1.0;
        use_active_for_splits = true;
        pseudotile = "yes";
        preserve_split = "yes";
      };

      master = {
        mfact = 0.6;
        inherit_fullscreen = true;
        # no_gaps_when_only = false;
      };

      decoration = {
        rounding = 0;
        # active_opacity = 0.90;
        # inactive_opacity = 0.90;
        # fullscreen_opacity = 1.0;

        blur = {
          enabled = true;
          size = 3;
          passes = 2;
          brightness = 1;
          contrast = 1.4;
          ignore_opacity = true;
          noise = 0;
          new_optimizations = true;
          xray = true;
        };

        shadow = {
          enabled = true;

          ignore_window = true;
          offset = "0 2";
          range = 20;
          render_power = 3;
          # color = "rgba(00000055)";
        };
      };

      animations = {
        enabled = true;

        bezier = [
          "fluent_decel, 0, 0.2, 0.4, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutCubic, 0.33, 1, 0.68, 1"
          "fade_curve, 0, 0.55, 0.45, 1"
        ];

        animation = [
          # name, enable, speed, curve, style

          # Windows
          "windowsIn,   0, 4, easeOutCubic,  popin 20%" # window open
          "windowsOut,  0, 4, fluent_decel,  popin 80%" # window close.
          "windowsMove, 1, 2, fluent_decel, slide" # everything in between, moving, dragging, resizing.

          # Fade
          "fadeIn,      1, 3,   fade_curve" # fade in (open) -> layers and windows
          "fadeOut,     1, 3,   fade_curve" # fade out (close) -> layers and windows
          "fadeSwitch,  0, 1,   easeOutCirc" # fade on changing activewindow and its opacity
          "fadeShadow,  1, 10,  easeOutCirc" # fade on changing activewindow for shadows
          "fadeDim,     1, 4,   fluent_decel" # the easing of the dimming of inactive windows
          # "border,      1, 2.7, easeOutCirc"  # for animating the border's color switch speed
          # "borderangle, 1, 30,  fluent_decel, once" # for animating the border's gradient angle - styles: once (default), loop
          "workspaces,  1, 4,   easeOutCubic, fade" # styles: slide, slidevert, fade, slidefade, slidefadevert
        ];
      };

      # variables
      "$mainMod" = "SUPER";
      "$shftMod" = "SUPER SHIFT";
      "$floatCenter" = "[float; center; size 900 600]";

      "$term" = "alacritty";
      "$browser" = "microsoft-edge";
      "$fileManager" = "nautilus";
      "$codeEditor" = "code";
      "$discordClient" = "vesktop";
      "$taskMgr" = "ticktick";
      "$nixConf" = "alacritty --class nixconf -e tat ~/nix/config";
      "$electronArgs" = "--enable-features=UseOzonePlatform --ozone-platform=wayland";

      bind = [
        "$mainMod, Q, killactive,"
        "$shftMod, Q, exec, hyprlock"
        "$shftMod ALT, Q, exit"

        "$mainMod, F, fullscreen, 1"
        "$shftMod, F, fullscreen, 0"
        "$mainMod, Space, togglefloating"
        "$mainMod, R, exec, rofi -show drun || pkill rofi"

        # applications
        "$shftMod, T, exec, $term"
        "$mainMod, B, exec, $browser"
        "$mainMod, E, exec, $fileManager"
        "$shftMod, E, exec, $floatCenter $fileManager"
        "$mainMod, M, exec, spotify $electronArgs"
        "$mainMod, I, exec, $discordClient $electronArgs"
        "$shftMod, Escape, exec, [workspace special:confws; float; center; size 1200 600] $term --class htop -e 'htop'"

        "$mainMod, N, exec, swaync-client -t -sw"

        # clipboard manager
        # "$shftMod, V, exec, cliphist list | rofi -dmenu -theme-str 'window {width: 50%;} listview {columns: 1;}' | cliphist decode | wl-copy"
        "$mainMod, V, exec, $floatCenter $term --title clipse -e clipse"

        # screenshot
        "$mainMod ALT, S, exec, hyprshot -m output"
        "$shftMod ALT, S, exec, hyprshot -m region"
        "$mainMod, S, exec, hyprshot -m output --clipboard-only"
        "$shftMod, S, exec, hyprshot -m region --clipboard-only"

        # switch windows
        "ALT, left, movefocus, l"
        "ALT, right, movefocus, r"
        "ALT, up, movefocus, u"
        "ALT, down, movefocus, d"
        "ALT, h, movefocus, l"
        "ALT, l, movefocus, r"
        "ALT, k, movefocus, u"
        "ALT, j, movefocus, d"

        # window/group control
        "ALT, d, togglegroup"
        "ALT, TAB, cyclenext"
        "ALT SHIFT, left, movewindoworgroup, l"
        "ALT SHIFT, right, movewindoworgroup, r"
        "ALT SHIFT, up, movewindoworgroup, u"
        "ALT SHIFT, down, movewindoworgroup, d"
        "ALT SHIFT, h, movewindoworgroup, l"
        "ALT SHIFT, j, movewindoworgroup, d"
        "ALT SHIFT, k, movewindoworgroup, u"
        "ALT SHIFT, l, movewindoworgroup, r"

        # switch workspace
        "$mainMod, a, togglespecialworkspace, taskws"
        "$mainMod, t, togglespecialworkspace, termws"
        "$mainMod, Escape, togglespecialworkspace, confws"
        "$mainMod, z, workspace, 1"
        "$mainMod, x, workspace, 2"
        "$mainMod, c, workspace, 3"

        "$mainMod, 0, workspace, 1"
        "$mainMod, 1, workspace, 2"
        "$mainMod, 2, workspace, 3"
        "$mainMod, 3, workspace, 4"
        "$mainMod, 4, workspace, 5"
        "$mainMod, 5, workspace, 6"
        "$mainMod, 6, workspace, 7"
        "$mainMod, 7, workspace, 8"
        "$mainMod, 8, workspace, 9"
        "$mainMod, 9, workspace, 10"

        "$mainMod, left, workspace, -1"
        "$mainMod, right, workspace, +1"
        "$mainMod, h, workspace, -1"
        "$mainMod, l, workspace, +1"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$shftMod, 0, movetoworkspace, 1"
        "$shftMod, 1, movetoworkspace, 2"
        "$shftMod, 2, movetoworkspace, 3"
        "$shftMod, 3, movetoworkspace, 4"
        "$shftMod, 4, movetoworkspace, 5"
        "$shftMod, 5, movetoworkspace, 6"
        "$shftMod, 6, movetoworkspace, 7"
        "$shftMod, 7, movetoworkspace, 8"
        "$shftMod, 8, movetoworkspace, 9"
        "$shftMod, 9, movetoworkspace, 10"

        "$shftMod, left, movetoworkspace, -1"
        "$shftMod, right, movetoworkspace, +1"
        "$shftMod, h, movetoworkspace, -1"
        "$shftMod, l, movetoworkspace, +1"

        "$mainMod CTRL, left, resizeactive, -80 0"
        "$mainMod CTRL, right, resizeactive, 80 0"
        "$mainMod CTRL, up, resizeactive, 0 -80"
        "$mainMod CTRL, down, resizeactive, 0 80"
        "$mainMod CTRL, h, resizeactive, -80 0"
        "$mainMod CTRL, j, resizeactive, 0 80"
        "$mainMod CTRL, k, resizeactive, 0 -80"
        "$mainMod CTRL, l, resizeactive, 80 0"

        "$mainMod ALT, left, moveactive,  -80 0"
        "$mainMod ALT, right, moveactive, 80 0"
        "$mainMod ALT, up, moveactive, 0 -80"
        "$mainMod ALT, down, moveactive, 0 80"
        "$mainMod ALT, h, moveactive,  -80 0"
        "$mainMod ALT, j, moveactive, 0 80"
        "$mainMod ALT, k, moveactive, 0 -80"
        "$mainMod ALT, l, moveactive, 80 0"

        # media and volume controls
        # ",XF86AudioMute, exec, pamixer -t"
        ",XF86AudioPlay, exec, playerctl play-pause"
        ",XF86AudioNext, exec, playerctl next"
        ",XF86AudioPrev, exec, playerctl previous"
        ",XF86AudioStop, exec, playerctl stop"

        "$mainMod, mouse_down, workspace, e-1"
        "$mainMod, mouse_up, workspace, e+1"
      ];

      # # binds active in lockscreen
      # bindl = [
      #   # laptop brigthness
      #   ",XF86MonBrightnessUp, exec, brightnessctl set 5%+"
      #   ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      #   "$mainMod, XF86MonBrightnessUp, exec, brightnessctl set 100%+"
      #   "$mainMod, XF86MonBrightnessDown, exec, brightnessctl set 100%-"
      # ];

      # # binds that repeat when held
      # binde = [
      #   ",XF86AudioRaiseVolume,exec, pamixer -i 2"
      #   ",XF86AudioLowerVolume,exec, pamixer -d 2"
      # ];

      # mouse binding
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # windowrule
      windowrule = [
        "float,Viewnior"
        "center,Viewnior"
        "size 1200 800,Viewnior"
        "float,imv"
        "center,imv"
        "size 1200 725,imv"
        "float,mpv"
        "center,mpv"
        "tile,Aseprite"
        "size 1200 725,mpv"
        "float,audacious"
        "pin,rofi"
        "tile, neovide"
        "idleinhibit focus,mpv"
        "float,udiskie"
        "float,title:^(Transmission)$"
        "float,title:^(Volume Control)$"
        "float,title:^(Firefox — Sharing Indicator)$"
        "move 0 0,title:^(Firefox — Sharing Indicator)$"
        "size 700 450,title:^(Volume Control)$"
        "move 40 55%,title:^(Volume Control)$"
        "float, title:Bitwarden"
      ];

      # windowrulev2
      windowrulev2 = [
        "float, title:^(.*Picture-in-Picture.*)$"
        "float, class:^(xdg-desktop-portal-.*)$"
        "opacity 1.0 override 1.0 override, title:^(.*Picture-in-Picture.*)$"
        "pin, title:^(.*Picture-in-Picture.*)$"

        "opacity 1.0 override 1.0 override, title:^(.*imv.*)$"
        "opacity 1.0 override 1.0 override, title:^(.*mpv.*)$"
        "opacity 1.0 override 1.0 override, class:(Unity)"
        "opacity 1.0 override 1.0 override, class:(zen)"
        "opacity 1.0 override 1.0 override, class:(evince)"
        "workspace 1, class:evince"
        "workspace 1, class:Zotero"
        "workspace 4, class:teams-for-linux"
        "workspace 4, class:vesktop"
        "workspace 4, class:Slack"
        "workspace 6, class:Spotify"
        "workspace 6, class:org.qbittorrent.qBittorrent"
        "workspace special:taskws, class:$taskMgr"
        "workspace special:termws, class:$term"
        "workspace special:confws, class:nixconf"

        "float, class:Zotero, title:^(.*Progress.*)$"
        "opacity 0.5, class:Zotero, title:^(.*Progress.*)$"
        "float, class:Zotero, title:^(Zotero Settings)$"
        "float, class:Zotero, title:^(Plugins Manager.*)$"
        "float, class:org.qbittorrent.qBittorrent, title:^(?!qBittorrent).+$" # not working

        "float, class:^(zen.*)$, title:^(.*Private Browsing.*)$"
        "float, class:microsoft-edge, title:^(.*\\[InPrivate\\].*)$"

        "idleinhibit focus, class:mpv"
        "idleinhibit focus, class:dev.suyu_emu.suyu"
        "idleinhibit focus, class:vlc"
        "idleinhibit fullscreen, class:microsoft-edge"

        "center, class:^(org.gnome.FileRoller)$"
        "float, class:^(org.gnome.FileRoller)$"
        "size 850 500, class:^(org.gnome.FileRoller)$"

        "size 850 500, title:^(.*File Upload.*)$"

        "float,class:^(nm-.*)$"
        "float,class:^(.*blueman.*)$"
        "float,class:^(.*pavucontrol.*)$"
        "float,class:^(.*SoundWireServer.*)$"
        "float,class:^(.*.sameboy-wrapped.*)$"
        "float,class:^(.*file_progress.*)$"
        "float,class:^(.*confirm.*)$"
        "float,class:^(.*dialog.*)$"
        "float,class:^(.*download.*)$"
        "float,class:^(.*notification.*)$"
        "float,class:^(.*error.*)$"
        "float,class:^(.*confirmreset.*)$"
        "float,title:^(.*Open File.*)$"
        "float,title:^(.*File Upload.*)$"
        "float,title:^(.*branchdialog.*)$"
        "float,title:^(.*Confirm to replace files.*)$"
        "float,title:^(.*File Operation Progress.*)$"

        "opacity 0.0 override, class:xwaylandvideobridge"
        "noanim, class:xwaylandvideobridge"
        "noinitialfocus, class:xwaylandvideobridge"
        "maxsize 1 1, class:xwaylandvideobridge"
        "noblur, class:xwaylandvideobridge"

        # No gaps when only
        "bordersize 0, floating:0, onworkspace:w[t1]"
        "rounding 0, floating:0, onworkspace:w[t1]"
        "bordersize 0, floating:0, onworkspace:w[tg1]"
        "rounding 0, floating:0, onworkspace:w[tg1]"
        "bordersize 0, floating:0, onworkspace:f[1]"
        "rounding 0, floating:0, onworkspace:f[1]"
      ];

      # No gaps when only
      workspace = [
        "w[t1], gapsout:0, gapsin:0"
        "w[tg1], gapsout:0, gapsin:0"
        "f[1], gapsout:0, gapsin:0"
        "1, on-created-empty:zotero"
        "2, on-created-empty:obsidian"
        "3, on-created-empty:$browser"
        "special:taskws, on-created-empty:$taskMgr $electronArgs"
        "special:termws, on-created-empty:$term"
        "special:confws, on-created-empty:$nixConf"
      ];
    };

    extraConfig = "
      monitor=,preferred,auto,auto

      xwayland {
        force_zero_scaling = true
      }
    ";
  };
}
