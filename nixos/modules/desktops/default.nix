{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hyprland.nix
    ./kde.nix
    ./gnome.nix
    ./xfce.nix
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
      default = ../../../home-manager/modules/desktops/wallpapers/fall-forest.jpg;
      description = "Wallpaper filename.";
    };
  };
}
