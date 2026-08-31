{config, ...}: {
  imports = [
    ./waybar.nix
    ./style.nix
  ];
  programs.waybar.enable = config.programs.niri.enable;
}
