{ inputs, ... }:
{
  imports = [
    ./hyprland.nix
    ./config.nix
    ./hyprlock.nix
    ./variables.nix
    ./packages
    # inputs.hyprland.homeManagerModules.default
  ];
}
