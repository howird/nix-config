{...}: {
  imports = [
    ../../home-manager
    ../../home-manager/nixos-only.nix
  ];
  config = {
    programs.niri.enable = true;

    home.sessionVariables.GDK_SCALE = "1.6";
  };
}
