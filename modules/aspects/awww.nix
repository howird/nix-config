{...}: {
  # Wallpaper daemon. Part of den.aspects.bundles.waybar-shell; noctalia's
  # `[wallpaper]` engine replaces it. The service comes from niri-flake, so
  # this expects den.aspects.niri alongside it.
  den.aspects.awww.homeManager = {config, ...}: {
    services.awww.enable = true;

    programs.niri.settings = {
      spawn-at-startup = [
        {argv = ["awww" "img" "${config.stylix.image}"];}
      ];

      layer-rules = [
        {
          matches = [{namespace = "^wallpaper$";}];
          place-within-backdrop = true;
        }
      ];
    };
  };
}
