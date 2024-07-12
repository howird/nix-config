{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [inputs.plasma-manager.homeManagerModules.plasma-manager];
  config = lib.mkIf config.myDesktop.kde {
    # rm -frv ~/.config/plasma* ~/.config/k* ~/.local/share/plasma* ~/.gtkrc-2.0
    # then restart

    home.packages = with pkgs; [
      kdePackages.plasma-browser-integration
    ];

    programs.plasma = {
      enable = true;
      overrideConfig = true;

      configFile.plasmarc.Theme.name = "breeze-dark";
      configFile.kdeglobals.KDE.SingleClick = false;
      # this breaks my volume buttons so we use the above instead
      # workspace = {
      #   cursor.theme = "breeze_cursors";
      #   clickItemTo = "select";
      #   colorScheme = "BreezeDark";
      #   theme = "breeze-dark";
      #   lookAndFeel = "org.kde.breezedark.desktop";
      #   wallpaper = config.myWallpaper;
      # };

      hotkeys.commands = {
        "terminal" = {
          name = "Launch Terminal";
          key = "Meta+T";
          command = "alacritty";
        };
        "browser" = {
          name = "Launch Browser";
          key = "Meta+B";
          command = "vivaldi";
        };
        "obsidian" = {
          name = "Launch Obsidian";
          key = "Meta+O";
          command = "obsidian";
        };
        "code" = {
          name = "Launch Code";
          key = "Meta+C";
          command = "code";
        };
      };

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

      spectacle.shortcuts = {
        captureRectangularRegion = "Meta+Shift+S";
        captureActiveWindow = "Meta+Ctrl+S";
        captureCurrentMonitor = "Meta+Alt+S";

        recordRegion = "Meta+Shift+R";
        recordWindow = "Meta+Ctrl+R";
        recordScreen = "Meta+Alt+R";
      };

      shortcuts = {
        "kaccess"."Toggle Screen Reader On and Off" = [];

        kwin = {
          "Edit Tiles" = [];
          "Overview" = "Meta+Up";
          "Switch One Desktop Down" = [];
          "Switch One Desktop Up" = [];
          "Switch One Desktop to the Left" = "Meta+Left";
          "Switch One Desktop to the Right" = "Meta+Right";

          "Switch Window Up" = [];
          "Switch Window Down" = [];
          "Switch Window Right" = [];
          "Switch Window Left" = [];

          "Switch to Desktop 1" = "Meta+1";
          "Switch to Desktop 2" = "Meta+2";
          "Switch to Desktop 3" = "Meta+3";
          "Switch to Desktop 4" = "Meta+4";
          "Switch to Desktop 5" = "Meta+5";
          "Switch to Desktop 6" = "Meta+6";
          "Switch to Desktop 7" = "Meta+7";
          "Switch to Desktop 8" = "Meta+8";

          "Switch to Next Desktop" = [];
          "Switch to Previous Desktop" = [];

          "Window Close" = "Meta+Q";
          "Window Maximize" = "Meta+F";
          "Window Minimize" = "Meta+Shift+F";

          "Window One Desktop Down" = "Meta+Shift+Down";
          "Window One Desktop Up" = "Meta+Shift+Up";
          "Window One Desktop to the Left" = "Meta+Shift+Left";
          "Window One Desktop to the Right" = "Meta+Shift+Right";

          "Window Quick Tile Bottom" = [];
          "Window Quick Tile Left" = [];
          "Window Quick Tile Right" = [];
          "Window Quick Tile Top" = [];

          "Window to Desktop 1" = "Meta+Shift+1";
          "Window to Desktop 2" = "Meta+Shift+2";
          "Window to Desktop 3" = "Meta+Shift+3";
          "Window to Desktop 4" = "Meta+Shift+4";
          "Window to Desktop 5" = "Meta+Shift+5";
          "Window to Desktop 6" = "Meta+Shift+6";
          "Window to Desktop 7" = "Meta+Shift+7";
          "Window to Desktop 8" = "Meta+Shift+8";

          "Window to Next Desktop" = [];
          "Window to Next Screen" = [];
          "Window to Previous Desktop" = [];
          "Window to Previous Screen" = [];
        };

        plasmashell = {
          "activate task manager entry 1" = "Meta+Alt+1";
          "activate task manager entry 2" = "Meta+Alt+2";
          "activate task manager entry 3" = "Meta+Alt+3";
          "activate task manager entry 4" = "Meta+Alt+4";
          "activate task manager entry 5" = "Meta+Alt+5";
          "activate task manager entry 6" = "Meta+Alt+6";
          "activate task manager entry 7" = "Meta+Alt+7";
          "activate task manager entry 8" = "Meta+Alt+8";

          "manage activities" = "Meta+A";
          "next activity" = "Meta+Tab";
          "previous activity" = "Meta+Shift+Tab";
          "stop current activity" = "Meta+Shift+A";
          "switch to next activity" = [];
          "switch to previous activity" = [];
          "toggle do not disturb" = [];
        };

        ksmserver = {
          "Lock Session" = ["Meta+Shift+Q" "Screensaver"];
          "Log Out" = "Ctrl+Alt+Del";
          "Log Out Without Confirmation" = [];
          "Reboot" = [];
          "Reboot Without Confirmation" = [];
        };

        wacomtablet = {
          "Map to fullscreen" = "Meta+Ctrl+F";
          "Map to screen 1" = "Meta+Ctrl+1";
          "Map to screen 2" = "Meta+Ctrl+2";
          "Next Profile" = "Meta+Ctrl+N";
          "Previous Profile" = "Meta+Ctrl+P";
          "Toggle screen map selection" = "Meta+Ctrl+M";
          "Toggle stylus mode" = "Meta+Ctrl+S";
          "Toggle touch tool" = "Meta+Ctrl+T";
        };
      };

      configFile.kdeglobals.General = {
        "TerminalApplication" = "alacritty";
        "TerminalService" = "Alacritty.desktop";
        "fixed" = "JetBrainsMonoNL Nerd Font Mono,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
      };
      configFile.kcminputrc."Libinput/2362/628/PIXA3854:00 093A:0274 Touchpad"."NaturalScroll" = true;
    };
  };
}
