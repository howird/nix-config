{
  den,
  lib,
  ...
}: {
  # Facts a host declares about itself. Aspects read them off the `host` arg
  # and gate themselves, so a host sets a fact instead of also including the
  # aspect that consumes it. Strict: a misspelled key is an eval error.
  den.schema.host.imports = [
    den.lib.strict
    {
      options = {
        gpu = lib.mkOption {
          type = lib.types.nullOr (lib.types.enum ["amd" "nvidia"]);
          default = null;
          description = "Discrete/primary GPU vendor; drives den.aspects.graphics.";
        };
        gpuVulkan = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Use the nvidia vulkan-beta driver.";
        };
        keymap = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "Name of configs/keyboards/kanata/<keymap>.kbd for the built-in keyboard; null disables kanata.";
        };
        internalScale = lib.mkOption {
          type = lib.types.float;
          default = 1.0;
          description = "Scale for the built-in laptop panel.";
        };
        syncthing.id = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "This host's syncthing device id; null means no syncthing.";
        };
      };
    }
  ];
}
