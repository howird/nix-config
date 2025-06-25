{
  config,
  lib,
  ...
}: {
  wayland.windowManager.hyprland.settings = {
    group = {
      group_on_movetoworkspace = true;
      groupbar = let
        rgb = color: "rgb(${color})";
        green = rgb config.lib.stylix.colors.base0B;
        red = rgb config.lib.stylix.colors.base08;
        orange = rgb config.lib.stylix.colors.base0A;
        grey = rgb config.lib.stylix.colors.base03;
      in {
        render_titles = false;
        keep_upper_gap = false;
        indicator_height = 5;
        "col.active" = lib.mkForce green;
        "col.inactive" = lib.mkForce grey;
        "col.locked_active" = lib.mkForce red;
        "col.locked_inactive" = lib.mkForce orange;
      };
    };

    bind = [
      # switch windows
      "ALT, TAB, changegroupactive, f"
      "$mainMod, Escape, lockgroups, toggle"
      "$shftMod, Escape, togglegroup"

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
    ];
  };
}
