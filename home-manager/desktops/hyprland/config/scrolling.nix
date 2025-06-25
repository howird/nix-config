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
      # "ALT, TAB, layoutmsg, focus r"
      "$mainMod, Escape, layoutmsg, colresize +conf"
      "$shftMod, Escape, layoutmsg, fit visible"

      "ALT, left, layoutmsg, focus l"
      "ALT, right, layoutmsg, focus r"
      "ALT, h, layoutmsg, focus l"
      "ALT, down, layoutmsg, focus d"
      "ALT, up, layoutmsg, focus u"
      "ALT, j, layoutmsg, focus d"
      "ALT, k, layoutmsg, focus u"
      "ALT, l, layoutmsg, focus r"

      "ALT SHIFT, left, layoutmsg, movewindowto l"
      "ALT SHIFT, right, layoutmsg, movewindowto r"
      "ALT SHIFT, h, layoutmsg, movewindowto l"
      "ALT SHIFT, l, layoutmsg, movewindowto r"

      "ALT SHIFT, down, layoutmsg, move -200"
      "ALT SHIFT, up, layoutmsg, move +200"
      "ALT SHIFT, j, layoutmsg, move -200"
      "ALT SHIFT, k, layoutmsg, move +200"

      "ALT CTRL, down, layoutmsg, colresize -200"
      "ALT CTRL, up, layoutmsg, colresize +200"
      "ALT CTRL, j, layoutmsg, colresize -200"
      "ALT CTRL, k, layoutmsg, colresize +200"
    ];
  };
}
