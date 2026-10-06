{
  config,
  lib,
  ...
}: let
  cfg = config.programs.chromium;

  hostOf = url: builtins.head (lib.splitString "/" (lib.last (lib.splitString "://" url)));

  capitalize = s: lib.toUpper (builtins.substring 0 1 s) + builtins.substring 1 (-1) s;

  # chromium derives the --app window's wayland app_id from the url as
  # chrome-<host>_<path with / -> _>-<profile>; matching it lets the
  # compositor/launcher associate the window with this desktop entry.
  wmClassOf = url: let
    path = lib.removePrefix (hostOf url) (lib.last (lib.splitString "://" url));
  in "chrome-${hostOf url}_${builtins.replaceStrings ["/"] ["_"] path}-Default";
in {
  options.programs.chromium.apps = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule {
      options = {
        link = lib.mkOption {
          type = lib.types.str;
          description = "URL to open in the --app window.";
        };
        thumbnail = lib.mkOption {
          type = lib.types.either lib.types.str lib.types.path;
          default = "chromium";
          description = "Desktop entry icon: an image path or an icon theme name.";
        };
      };
    });
    default = {};
    example = lib.literalExpression ''
      {
        asana = {
          link = "https://app.asana.com/";
          thumbnail = ./asana.svg;
        };
      }
    '';
    description = "Apps to expose as standalone chromium --app desktop entries, keyed by name.";
  };

  config.xdg.desktopEntries = lib.mapAttrs' (name: app:
    lib.nameValuePair "chromium-app-${name}" {
      name = capitalize name;
      comment = app.link;
      exec = "${lib.getExe cfg.finalPackage} --app=${app.link}";
      icon = app.thumbnail;
      terminal = false;
      categories = ["Network"];
      settings.StartupWMClass = wmClassOf app.link;
    })
  cfg.apps;
}
