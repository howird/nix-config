{
  config,
  pkgs,
  lib,
  ...
}: {
  # yerm-only startup apps (nm-applet/poweralertd/blueman-applet) are added
  # via den.aspects.yerm.homeManager, projected onto howird by
  # den.batteries.host-aspects (see modules/hosts/yerm/host.nix).
  programs.niri.settings = {
    spawn-at-startup = [
      {argv = ["waybar"];}
      {argv = ["cursor-clip" "--daemon"];}
      {argv = ["swaync"];}
      {argv = ["uair" "-q"];}
      {argv = ["niri" "msg" "action" "focus-workspace" "note"];}
      {argv = ["obsidian"];}
      {argv = ["zotero"];}
      {argv = ["ghostty"];}
      {argv = ["uair-startup"];}
      {argv = ["awww" "img" "${config.stylix.image}"];}
    ];

    window-rules = [
      {
        matches = [
          {at-startup = true;}
        ];
        open-focused = false;
      }
    ];

    xwayland-satellite = {
      enable = true;
      path = lib.getExe pkgs.xwayland-satellite-unstable;
    };
  };
}
