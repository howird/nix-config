{
  pkgs,
  lib,
  ...
}: let
  name = "url-router";
  mimeTypes = [
    "text/html"
    "x-scheme-handler/http"
    "x-scheme-handler/https"
  ];
in {
  xdg.mimeApps.defaultApplications = lib.genAttrs mimeTypes (_: "${name}.desktop");

  home.packages = let
    script = pkgs.writeShellScriptBin name ''
      #!/bin/bash
      URL="$1"
      if [[ "$URL" == *"localhost"* || "$URL" == *"127.0.0.1"* ]]; then
          exec chromium "$URL"
      else
          exec zen-twilight "$URL"
      fi
    '';
  in [
    (pkgs.makeDesktopItem {
      inherit name mimeTypes;
      desktopName = name;
      exec = "${script}/bin/${name} %U";
      comment = "Routes URLs to different browsers based on hostname";
      terminal = false;
    })
  ];
}
