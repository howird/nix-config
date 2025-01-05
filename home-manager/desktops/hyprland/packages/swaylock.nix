{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      clock = true;
      daemonize = true;
      timestr = "%I:%M %p";
      datestr = "%b %d";
      screenshots = true;
      ignore-empty-password = true;

      indicator = true;
      indicator-radius = 150;
      indicator-thickness = 15;

      effect-blur = "7x5";
      effect-vignette = "0.75:0.75";
      effect-pixelate = 5;

      font = config.stylix.fonts.monospace.name;
    };
  };
}
