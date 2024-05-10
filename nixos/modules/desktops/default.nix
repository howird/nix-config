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
    myDesktop = lib.mkOption {
      type = lib.types.nonEmptyStr;
      default = "kde";
      description = ''must be "kde", "hyprland", or "gnome".'';
    };
  };
}
