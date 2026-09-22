{...}: {
  # Application launcher. Part of den.aspects.bundles.waybar-shell; noctalia's
  # launcher replaces it.
  den.aspects.rofi.homeManager = {config, ...}: {
    imports = [./_rofi/config.nix];

    programs.niri.settings = {
      binds."Mod+Return".action =
        config.lib.niri.actions.spawn "rofi" "-show" "drun";

      layer-rules = [
        {
          matches = [{namespace = "^launcher$";}];
          shadow.enable = true;
        }
      ];
    };
  };
}
