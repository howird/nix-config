{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hyprland
    ./kde
    ./gnome
    ./xfce
  ];

  options = with lib; {
    myDesktop = {
      gnome = mkEnableOption "gnome";
      hyprland = mkEnableOption "hyprland";
      kde = mkEnableOption "kde";
      kdeTheme = mkOption {
        type = types.str;
        default = "reactionary";
        description = "Theme name. Must be installed in nixos config.";
      };
      xfce = mkEnableOption "xfce";
    };
    myCursor = {
      theme = mkOption {
        type = types.str;
        default = "Posy_Cursor";
        description = "Cursor name. Must be installed in nixos config.";
      };
      size = mkOption {
        type = types.ints.positive;
        default = 32;
        description = "Cursor size.";
      };
    };
    myWallpaper = mkOption {
      type = types.path;
      default = ./wallpapers/pixel-art-rayquaza.png;
      description = "Wallpaper filename.";
    };
  };

  config = {  
    home.packages = lib.mkIf (!config.myDesktop.xfce) (with pkgs; [
      wl-clipboard-rs
      slurp
      grim
    ]);
  };
}
