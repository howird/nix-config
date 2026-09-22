{...}: {
  # Status bar for the niri session. Part of den.aspects.bundles.waybar-shell;
  # noctalia's bar replaces it.
  den.aspects.waybar.homeManager = {config, ...}: {
    imports = [
      ./_waybar/waybar.nix
      ./_waybar/style.nix
    ];

    programs.waybar.enable = true;
    programs.niri.settings.spawn-at-startup = [{argv = ["waybar"];}];

    stylix.targets.waybar.font =
      if config.desktop.font.useSerif
      then "serif"
      else "sansSerif";
  };
}
