# {config, ...}: {
{pkgs, ...}: {
  imports = [
    ./styles.nix
    ./hyprland.nix
  ];

  # services.swayosd.enable = config.myDesktop.hyprland;
  home.packages = with pkgs; [
    swayosd
  ];
}
