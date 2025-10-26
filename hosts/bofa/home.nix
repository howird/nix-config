{
  imports = [
    ../../home-manager
    ../../home-manager/nixos-only.nix
  ];
  config = {
    programs.niri.enable = true;
  };
}
