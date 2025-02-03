{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  config = lib.mkIf config.myDesktop.kde {
    programs.plasma = {
      hotkeys.commands = {
        # "terminal" = {
        #   name = "Launch Terminal";
        #   key = "Meta+T";
        #   command = "alacritty";
        # };
        # "browser" = {
        #   name = "Launch Browser";
        #   key = "Meta+B";
        #   command = "microsoft-edge";
        # };
        # "code" = {
        #   name = "Launch Code";
        #   key = "Meta+C";
        #   command = "code";
        # };
        # "obsidian" = {
        #   name = "Launch Obsidian";
        #   key = "Meta+O";
        #   command = "obsidian";
        # };
        # "rnote" = {
        #   name = "Launch rnote";
        #   key = "Meta+R";
        #   command = "flatpak run com.github.flxzt.rnote";
        # };
      };

      spectacle.shortcuts = {
        captureRectangularRegion = "Meta+Shift+S";
        captureActiveWindow = "Meta+Ctrl+S";
        captureCurrentMonitor = "Meta+Alt+S";

        recordRegion = "Meta+Shift+R";
        recordWindow = "Meta+Ctrl+R";
        recordScreen = "Meta+Alt+R";
      };

      shortcuts = {
        "services/flatpak.desktop"."_launch" = "Meta+N";
        "services/microsoft-edge.desktop"."_launch" = "Meta+B";
        "services/obsidian.desktop"."_launch" = "Meta+O";
        "services/code.desktop"."_launch" = "Meta+C";
        "services/Alacritty.desktop"."_launch" = "Meta+T";
        "services/spotify.desktop"."_launch" = "Meta+M";
        "services/zotero.desktop"."_launch" = "Meta+Z";
        "services/org.kde.krunner.desktop"."_launch" = ["Search" "Meta+R"];
        "services/vesktop.desktop"."_launch" = "Meta+I";
        "kwin"."Show Desktop" = "none,Meta+D,Peek at Desktop";

        "kaccess"."Toggle Screen Reader On and Off" = [];

        kwin = {
          "Edit Tiles" = [];
          "Overview" = ["Meta+Up" "Meta+K"];
          "Switch One Desktop Down" = [];
          "Switch One Desktop Up" = [];
          "Switch One Desktop to the Left" = ["Meta+Left" "Meta+H"];
          "Switch One Desktop to the Right" = ["Meta+Right" "Meta+L"];

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

          "Window One Desktop Down" = ["Meta+Shift+Down" "Meta+Shift+J"];
          "Window One Desktop Up" = ["Meta+Shift+Up" "Meta+Shift+K"];
          "Window One Desktop to the Left" = ["Meta+Shift+Left" "Meta+Shift+H"];
          "Window One Desktop to the Right" = ["Meta+Shift+Right" "Meta+Shift+L"];

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
    };
  };
}
