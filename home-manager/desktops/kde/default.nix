{
  inputs,
  lib,
  config,
  host,
  ...
}: {
  imports = [
    inputs.plasma-manager.homeManagerModules.plasma-manager
    ./shortcuts.nix
    ./themes.nix
  ];

  # rm -frv ~/.cache/plasma* ~/.config/plasma* ~/.config/k* ~/.local/share/plasma* ~/.gtkrc-2.0
  # then restart
  config = {
    programs.plasma = {
      overrideConfig = true;

      workspace.clickItemTo = "select";

      kwin = {
        titlebarButtons.right = ["minimize" "maximize" "close"];
        titlebarButtons.left = ["on-all-desktops" "keep-above-windows"];

        virtualDesktops = {
          rows = 1;
          names = ["[ Main ]" "[ Learn ]" "[ Side ]" " [ Misc ]"];
        };
      };

      panels = [
        {
          height = 36;
          lengthMode = "fill";
          location = "bottom";
          alignment = "center";
          hiding = "none";
          floating = false;
          # search in:
          # ls /run/current-system/sw/share/plasma/plasmoids
          widgets = [
            "org.kde.plasma.kickoff"
            "org.kde.plasma.marginsseparator"
            "com.github.tilorenz.compact_pager"
            "org.kde.plasma.marginsseparator"
            "com.dv.fokus"
            "org.kde.plasma.marginsseparator"
            "org.kde.plasma.marginsseparator"
            "org.kde.plasma.taskmanager"
            "org.kde.plasma.marginsseparator"
            "org.kde.plasma.systemtray"
            "org.kde.plasma.digitalclock"
            "org.kde.plasma.showdesktop"
          ];
          screen = 0;
        }
      ];

      configFile.kdeglobals.General = {
        "TerminalApplication" = "alacritty";
        "TerminalService" = "Alacritty.desktop";
        "fixed" = "${config.stylix.fonts.monospace.name},10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
      };

      powerdevil.AC = lib.mkIf (host == "bofa") {
        autoSuspend.action = "nothing";
        turnOffDisplay.idleTimeout = 600;
        turnOffDisplay.idleTimeoutWhenLocked = "whenLockedAndUnlocked";
      };

      configFile.kded5rc."Module-browserintegrationreminder"."autoload" = false;
      configFile.kcminputrc."Libinput/2362/628/PIXA3854:00 093A:0274 Touchpad"."NaturalScroll" = true;

      configFile.krunnerrc = {
        General.FreeFloating = true;
        Plugins.baloosearchEnabled = true;
      };

      configFile.baloofilerc = {
        "Basic Settings".Indexing-Enabled = false;
        General = {
          "exclude folders[$e]" = "$HOME/,/nix/";
          "folders[$e]" = "$HOME/Desktop/,$HOME/Documents/,$HOME/Downloads/,$HOME/Pictures/,$HOME/Videos/";
        };
      };
    };
  };

  options = with lib; {
    myDesktop = {
      kdeTheme = mkOption {
        type = types.str;
        default = "reactionary";
        description = "Theme name. Must be installed in nixos config.";
      };
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
  };
}
