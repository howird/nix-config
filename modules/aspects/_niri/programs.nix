{
  pkgs,
  lib,
  ...
}: {
  programs.niri.settings = {
    spawn-at-startup = [
      {argv = ["uair" "-q"];}
      {argv = ["obsidian"];}
      {argv = ["zotero"];}
      {argv = ["ghostty"];}
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
