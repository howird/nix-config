{inputs, ...}: {
  imports = [
    ./hyprland.nix
    ./config.nix
    ./hyprlock.nix
    ./hypridle.nix
    ./packages
    # inputs.hyprland.homeManagerModules.default
  ];
  home.sessionVariables = import ./variables.nix;
}
