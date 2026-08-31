{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./niri
    ./packages
  ];

  config = {
    home.packages = with pkgs; [
      wl-clipboard-rs
      slurp
      grim
    ];

    desktop.font.name =
      if config.desktop.font.useSerif
      then config.stylix.fonts.serif.name
      else config.stylix.fonts.sansSerif.name;

    stylix.targets.waybar.font =
      if config.desktop.font.useSerif
      then "serif"
      else "sansSerif";
  };

  options = {
    programs.niri.enable = lib.mkEnableOption "niri";
    desktop.font = {
      useSerif = lib.mkEnableOption "useSerif";
      name = lib.mkOption {
        type = lib.types.str;
        description = "Name of the font.";
      };
    };
  };
}
