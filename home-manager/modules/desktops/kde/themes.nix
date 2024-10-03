{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  config = lib.mkIf config.myDesktop.kde {
    programs.plasma = let
      # plasma-apply-desktoptheme --list-themes
      # plasma-apply-colorscheme --list-schemes
      theme2colorscheme = {
        expose = "Expose";
        reactionary = "Reactionary";
        commonality = "Commonality";
      };
      # plasma-apply-lookandfeel --list
      theme2lookandfeel = {
        expose = "org.magpie.expose.desktop";
        reactionary = "org.magpie.react.desktop";
        commonality = "org.magpie.comm.desktop";
      };
      # ls /run/current-system/sw/share/icons/
      theme2icons = {
        expose = "Oxygen";
        reactionary = "Reactionary";
        commonality = "NsCDE";
      };
    in {
      kwin.effects = {
        shakeCursor.enable = true;
        desktopSwitching.animation = "off";
        translucency.enable = false;
        blur.enable = false;
      };

      # ls /run/current-system/sw/share/color-schemes/
      configFile.kdeglobals.KDE.widgetStyle = "Windows";
      workspace.cursor = config.myCursor;
      workspace.theme = config.myDesktop.kdeTheme;
      workspace.colorScheme = builtins.getAttr config.myDesktop.kdeTheme theme2colorscheme;
      workspace.lookAndFeel = builtins.getAttr config.myDesktop.kdeTheme theme2lookandfeel;
      # workspace.iconTheme = builtins.getAttr config.myDesktop.kdeTheme theme2icons;
      workspace.iconTheme = "NsCDE"; # dont use default icons, i like this one more

      # cat ~/.config/kwinrc
      # workspace.splashScreen
      # workspace.windowDecorations

      workspace.wallpaper = config.myWallpaper;
      kscreenlocker.appearance.wallpaper = config.myWallpaper;
    };
  };
}
