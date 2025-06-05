{
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";
    "$shftMod" = "SUPER SHIFT";
    "$floatCenter" = "[float; center; size 900 600]";

    bind = [
      "$mainMod, Q, killactive,"
      "$shftMod, Q, exec, hyprlock"
      "$shftMod ALT, Q, exit"

      "$mainMod, F, fullscreen, 1"
      "$shftMod, F, fullscreen, 0"
      "$mainMod, Space, togglefloating"
      "$mainMod, Return, exec, rofi -show drun || pkill rofi"

      # applications
      "$mainMod, N, exec, swaync-client -t -sw"

      # clipboard manager
      # "$shftMod, V, exec, cliphist list | rofi -dmenu -theme-str 'window {width: 50%;} listview {columns: 1;}' | cliphist decode | wl-copy"
      # "$mainMod, V, exec, $floatCenter $term -e clipse"

      # screenshot
      "$mainMod ALT, S, exec, hyprshot -m output"
      "$shftMod ALT, S, exec, hyprshot -m region"
      "$mainMod, S, exec, hyprshot -m output --clipboard-only"
      "$shftMod, S, exec, hyprshot -m region --clipboard-only"

      # switch windows
      "$shftMod, Escape, togglegroup"
      "$mainMod, Escape, lockactivegroup, toggle"
      "ALT, TAB, changegroupactive, b"

      "ALT, left, movefocus, l"
      "ALT, right, movefocus, r"
      "ALT, up, movefocus, u"
      "ALT, down, movefocus, d"
      "ALT, h, movefocus, l"
      "ALT, l, movefocus, r"
      "ALT, k, movefocus, u"
      "ALT, j, movefocus, d"

      # window/group control
      "ALT SHIFT, left, movewindoworgroup, l"
      "ALT SHIFT, right, movewindoworgroup, r"
      "ALT SHIFT, up, movewindoworgroup, u"
      "ALT SHIFT, down, movewindoworgroup, d"
      "ALT SHIFT, h, movewindoworgroup, l"
      "ALT SHIFT, j, movewindoworgroup, d"
      "ALT SHIFT, k, movewindoworgroup, u"
      "ALT SHIFT, l, movewindoworgroup, r"

      "$mainMod, TAB, workspace, previous_per_monitor"
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod, 7, workspace, 7"
      "$mainMod, 8, workspace, 8"
      "$mainMod, 9, workspace, 9"

      "$mainMod, left, workspace, -1"
      "$mainMod, right, workspace, +1"

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      "$shftMod, 1, movetoworkspace, 1"
      "$shftMod, 2, movetoworkspace, 2"
      "$shftMod, 3, movetoworkspace, 3"
      "$shftMod, 4, movetoworkspace, 4"
      "$shftMod, 5, movetoworkspace, 5"
      "$shftMod, 6, movetoworkspace, 6"
      "$shftMod, 7, movetoworkspace, 7"
      "$shftMod, 8, movetoworkspace, 8"
      "$shftMod, 9, movetoworkspace, 9"

      "$shftMod, left, movetoworkspace, -1"
      "$shftMod, right, movetoworkspace, +1"

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

    # mouse binding
    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];
  };
}
