{...}: {
  # On-screen display for volume/brightness/lock keys. Part of
  # den.aspects.bundles.waybar-shell; noctalia's OSD replaces it.
  den.aspects.swayosd.homeManager = {
    imports = [
      ./_swayosd/styles.nix
      ./_swayosd/niri.nix
    ];

    services.swayosd.enable = true;
  };
}
