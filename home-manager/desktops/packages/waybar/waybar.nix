{
  config,
  pkgs,
  ...
}: {
  programs.waybar = {
    enable = config.programs.niri.enable || config.programs.hyprland.enable;
    package = pkgs.waybar.overrideAttrs (oa: {
      mesonFlags = (oa.mesonFlags or []) ++ ["-Dexperimental=true"];
    });
  };
}
