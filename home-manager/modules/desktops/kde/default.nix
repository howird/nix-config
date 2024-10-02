{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.plasma-manager.homeManagerModules.plasma-manager
    ./shortcuts.nix
  ];

  # rm -frv ~/.config/plasma* ~/.config/k* ~/.local/share/plasma* ~/.gtkrc-2.0
  # then restart
  config = lib.mkIf config.myDesktop.kde {
    programs.plasma = {
      enable = true;
      overrideConfig = true;

      workspace = {
        clickItemTo = "select";
        theme = "expose";
        colorScheme = "Expose";
        cursor.theme = "Afterglow-cursors";
        lookAndFeel = "org.magpie.expose.desktop";
        iconTheme = "Oxygen";
        splashScreen.theme = "SimpleTuxSplash-Plasma6";
        windowDecorations = {
          library = "org.kde.kwin.aurorae";
          theme = "__aurorae__svg__expose";
        };
        wallpaper = config.myWallpaper;
      };
      configFile.kdeglobals.KDE.widgetStyle = "Windows";

      kwin = {
        titlebarButtons.right = ["minimize" "maximize" "close"];
        titlebarButtons.left = ["on-all-desktops" "keep-above-windows"];

        effects = {
          shakeCursor.enable = true;
          translucency.enable = true;
          desktopSwitching.animation = "slide";
          blur.enable = true;
        };

        virtualDesktops = {
          rows = 1;
          names = ["Impl - Main" "Learning" "Impl - Side" "Misc"];
        };
      };

      # panels = [
      #   {
      #     height = 48;
      #     lengthMode = "fill";
      #     location = "bottom";
      #     alignment = "center";
      #     hiding = "dodgewindows";
      #     floating = true;
      #     # search in:
      #     # plasma-workspace-*/share/plasma/plasmoids
      #     # kdeplasma-addons-*/share/plasma/plasmoids
      #     widgets = [
      #       "org.kde.plasma.kickoff"
      #       "org.kde.plasma.pager"
      #       "org.kde.plasma.icontasks"
      #       "org.kde.plasma.marginsseparator"
      #       "org.kde.plasma.mediacontroller"
      #       "org.kde.plasma.systemtray"
      #       "org.kde.plasma.digitalclock"
      #     ];
      #     screen = 0;
      #   }
      # ];

      configFile.kdeglobals.General = {
        "TerminalApplication" = "alacritty";
        "TerminalService" = "Alacritty.desktop";
        "fixed" = "JetBrainsMonoNL Nerd Font Mono,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
      };

      configFile.kded5rc."Module-browserintegrationreminder"."autoload" = false;
      configFile.kcminputrc."Libinput/2362/628/PIXA3854:00 093A:0274 Touchpad"."NaturalScroll" = true;
    };
  };
}
