{
  wayland.windowManager.hyprland.settings = {
    general.layout = "scrolling";

    plugin.hyprscrolling = {
      fullscreen_on_one_column = true;
      column_width = 0.75;
      explicit_column_widths = "0.5, 0.75, 1.0";
      focus_fit_method = 0;
    };

    bind = [
      "ALT, TAB, cyclenext, prev hist"
      "$mainMod, Escape, layoutmsg, colresize +conf"
      "$shftMod, Escape, layoutmsg, fit visible"

      "ALT, left, layoutmsg, focus l"
      "ALT, right, layoutmsg, focus r"
      "ALT, h, layoutmsg, focus l"
      "ALT, l, layoutmsg, focus r"

      "ALT, down, layoutmsg, focus d"
      "ALT, up, layoutmsg, focus u"
      "ALT, j, layoutmsg, focus d"
      "ALT, k, layoutmsg, focus u"

      "ALT SHIFT, left, layoutmsg, movewindowto l"
      "ALT SHIFT, right, layoutmsg, movewindowto r"
      "ALT SHIFT, h, layoutmsg, movewindowto l"
      "ALT SHIFT, l, layoutmsg, movewindowto r"

      "ALT CTRL, down, layoutmsg, colresize -200"
      "ALT CTRL, up, layoutmsg, colresize +200"
      "ALT CTRL, j, layoutmsg, colresize -200"
      "ALT CTRL, k, layoutmsg, colresize +200"

      "$mainMod CTRL, down, movecurrentworkspacetomonitor, -1"
      "$mainMod CTRL, up, movecurrentworkspacetomonitor, +1"
      "$mainMod CTRL, j, movecurrentworkspacetomonitor, 1"
      "$mainMod CTRL, k, movecurrentworkspacetomonitor, -1"

      "$mainMod CTRL, left, layoutmsg, move -200"
      "$mainMod CTRL, right, layoutmsg, move +200"
      "$mainMod CTRL, left, layoutmsg, move -200"
      "$mainMod CTRL, right, layoutmsg, move +200"
    ];
  };
}
