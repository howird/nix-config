{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./kde.nix
    ./gnome.nix
    ./hyprland.nix
  ];

  options = {
    myDesktop = {
      kde = lib.mkEnableOption "kde";
      hyprland = lib.mkEnableOption "hyprland";
      gnome = lib.mkEnableOption "gnome";
    };

    myWallpaper = lib.mkOption {
      type = lib.types.path;
      default = ../../../home-manager/modules/desktops/wallpapers/fall-forest.jpg;
      description = "Wallpaper filename.";
    };
  };
}
