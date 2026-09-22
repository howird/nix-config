{...}: {
  # Notification daemon and control centre. Part of
  # den.aspects.bundles.waybar-shell; noctalia's notification daemon
  # replaces it.
  den.aspects.swaync.homeManager = {
    config,
    pkgs,
    ...
  }: {
    imports = [./_swaync/style.nix];

    home.packages = [pkgs.swaynotificationcenter];
    xdg.configFile."swaync/config.json".source = ./_swaync/config.json;

    programs.niri.settings = {
      spawn-at-startup = [{argv = ["swaync"];}];
      binds."Mod+N".action =
        config.lib.niri.actions.spawn "swaync-client" "-t" "-sw";

      layer-rules = [
        {
          matches = [{namespace = "^notifications$";}];
          block-out-from = "screencast";
        }
      ];
    };
  };
}
