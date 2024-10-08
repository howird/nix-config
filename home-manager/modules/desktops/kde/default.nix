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
    ./themes.nix
  ];

  # rm -frv ~/.cache/plasma* ~/.config/plasma* ~/.config/k* ~/.local/share/plasma* ~/.gtkrc-2.0
  # then restart
  config = lib.mkIf config.myDesktop.kde {
    programs.plasma = {
      enable = true;
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
            "org.kde.plasma.mediacontroller"
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
        "fixed" = "JetBrainsMonoNL Nerd Font Mono,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
      };

      configFile.kded5rc."Module-browserintegrationreminder"."autoload" = false;
      configFile.kcminputrc."Libinput/2362/628/PIXA3854:00 093A:0274 Touchpad"."NaturalScroll" = true;
      configFile.krunnerrc.General.FreeFloating = true;
    };
  };
}
