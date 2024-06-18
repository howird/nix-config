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
    programs.plasma = {
      enable = true;
      overrideConfig = true;

      shortcuts = {
        kwin = {
          "Overview" = "Meta+Up";
          "Switch One Desktop Down" = [];
          "Switch One Desktop Up" = [];
          "Switch One Desktop to the Left" = "Meta+Left";
          "Switch One Desktop to the Right" = "Meta+Right";

          "Switch Window Up" = [];
          "Switch Window Down" = [];
          "Switch Window Right" = "Meta+Shift+Right";
          "Switch Window Left" = "Meta+Shift+Left";

          "Switch to Desktop 1" = "Meta+1";
          "Switch to Desktop 2" = "Meta+2";
          "Switch to Desktop 3" = "Meta+3";
          "Switch to Desktop 4" = "Meta+4";
          "Switch to Desktop 5" = "Meta+5";
          "Switch to Desktop 6" = "Meta+6";
          "Switch to Desktop 7" = "Meta+7";
          "Switch to Desktop 8" = "Meta+8";
          "Switch to Next Desktop" = "Meta+Tab";
          "Switch to Previous Desktop" = "Meta+Shift+Tab";

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
          "Window to Desktop 9" = "Meta+Shift+9";

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
          "next activity" = "Meta+Ctrl+Tab";
          "previous activity" = "Meta+Ctrl+Shift+Tab";
          "stop current activity" = "Meta+Ctrl+Q";
          "switch to next activity" = [];
          "switch to previous activity" = [];
          "toggle do not disturb" = [];
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

      configFile = {
        "kscreenlockerrc"."Greeter/Wallpaper/org.kde.image/General"."Image" = "${config.myWallpaper}";
        "kscreenlockerrc"."Greeter/Wallpaper/org.kde.image/General"."PreviewImage" = "${config.myWallpaper}";
        "plasma-localerc"."Formats"."LANG" = "en_US.UTF-8";
      };
    };
  };
}
