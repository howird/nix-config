{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hyprland
    ./kde
    ./gnome
    ./xfce
  ];

  options = {
    myDesktop = {
      kde = lib.mkEnableOption "kde";
      hyprland = lib.mkEnableOption "hyprland";
      gnome = lib.mkEnableOption "gnome";
      xfce = lib.mkEnableOption "xfce";
    };
    myWallpaper = lib.mkOption {
      type = lib.types.path;
      default = ./wallpapers/fall-forest.jpg;
      description = "Wallpaper filename.";
    };
  };
}
