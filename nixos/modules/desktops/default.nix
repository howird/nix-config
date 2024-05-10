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
      kde = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to enable kde.";
      };
      hyprland = lib.mkEnableOption "hyprland";
      gnome = lib.mkEnableOption "gnome";
    };
  };
}
