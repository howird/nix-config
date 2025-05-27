{lib, ...}: {
  imports = [
    ./hyprland.nix
    ./kde.nix
    ./gnome.nix
    ./xfce.nix
  ];

  options = {
    myDesktop = {
      kde = lib.mkEnableOption "kde";
      hyprland = lib.mkEnableOption "hyprland";
      gnome = lib.mkEnableOption "gnome";
      xfce = lib.mkEnableOption "xfce";
    };
  };
}
