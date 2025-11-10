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
        {argv = ["swayosd-server"];}
        {argv = ["swww" "img" "${config.stylix.image}"];}
        {argv = ["uair" "-q"];}
        {argv = ["niri" "msg" "action" "focus-workspace" "note"];}
        {argv = ["zellij" "d" "taskwarrior"];}
        {
          argv = [
            "ghostty"
            "--class=task.warrior"
            "--title=taskwarrior"
            "-e"
            "zellij"
            "--session"
            "taskwarrior"
            "--new-session-with-layout"
            "/home/${config.home.username}/.config/zellij/layouts/task.kdl"
          ];
        }
        {argv = ["obsidian"];}
        {argv = ["zotero"];}
        {argv = ["zen-twilight"];}
        {argv = ["ghostty"];}
        {argv = ["start-day"];}
      ]
      ++ lib.optionals (host == "yerm") [
        {argv = ["nm-applet"];}
        {argv = ["poweralertd"];}
        {argv = ["blueman-applet"];}
      ];

    xwayland-satellite = {
      enable = true;
      path = lib.getExe pkgs.xwayland-satellite-unstable;
    };
  };
}
