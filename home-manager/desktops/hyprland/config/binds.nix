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
      "$mainMod, V, exec, $floatCenter $term -e clipse"

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
