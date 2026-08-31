{config, ...}: {
  imports = [
    ./styles.nix
    ./niri.nix
  ];

  services.swayosd.enable = config.programs.niri.enable;
}
