{...}: {
  # Lock screen. Part of den.aspects.bundles.waybar-shell; noctalia's
  # `[lockscreen]` replaces it.
  den.aspects.hyprlock.homeManager = {config, ...}: {
    imports = [./_hyprlock/config.nix];

    programs.niri.settings.binds."Super+Shift+Q".action =
      config.lib.niri.actions.spawn "hyprlock";
  };
}
