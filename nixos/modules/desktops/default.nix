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
  };
}
