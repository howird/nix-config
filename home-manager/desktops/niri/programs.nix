{
  config,
  pkgs,
  lib,
  host,
  ...
}: {
  programs.niri.settings = {
    spawn-at-startup =
      [
        {argv = ["waybar"];}
        {argv = ["swaync"];}
        {argv = ["uair" "-q"];}
        {argv = ["niri" "msg" "action" "focus-workspace" "note"];}
        {argv = ["obsidian"];}
        {argv = ["zotero"];}
        {argv = ["ghostty"];}
        {argv = ["uair-startup"];}
        {argv = ["awww" "img" "${config.stylix.image}"];}
      ]
      ++ lib.optionals (host == "yerm") [
        {argv = ["nm-applet"];}
        {argv = ["poweralertd"];}
        {argv = ["blueman-applet"];}
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
