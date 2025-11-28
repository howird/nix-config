{config, ...}: {
  programs.waybar.style = let
    fontWeight = "500";
    opacity = "1";

    colors = config.lib.stylix.colors.withHashtag;
    text = colors.base05;
    base = colors.base00;
    mantle = colors.base01;
    surface1 = colors.base03;
    red = colors.base08;
    orange = colors.base09;
    yellow = colors.base0A;
    green = colors.base0B;
    aqua = colors.base0C;
    blue = colors.base0D;
  in ''
    * {
      border: none;
      border-radius: 0px;
      padding: 0;
      margin: 0;
      /* font-family and font-size set by stylix, see desktop/default.nix */
      opacity: ${opacity};
      font-weight: ${fontWeight};
    }

    window#waybar {
      background: ${base};
    }

    tooltip {
      background: ${mantle};
      border: 1px solid ${surface1};
    }
    tooltip label {
      margin: 5px;
    }

    #workspaces {
      padding-left: 10px;
    }
    #workspaces button {
      padding-left:  5px;
      padding-right: 5px;
      margin-right: 10px;
    }
    #workspaces button.active, #custom-uair-time.resumed { color: ${green}; }
    #custom-uair-time.paused { color: ${red}; }
    #custom-uair.settling-my-mind { color: ${yellow}; }
    #custom-uair.meditating { color: ${orange}; }
    #custom-uair.intention-setting { color: ${aqua}; }
    #custom-uair.working { color: ${blue}; }
    #custom-uair.resting { color: ${orange}; }

    #clock, #tray, #workspaces button, tooltip label {
      color: ${text};
    }

    #tray {
      margin-right: 5px;
    }
    #tray menu {
      background: ${mantle};
      border: 1px solid ${surface1};
      padding: 5px;
    }
    #tray menuitem {
      padding: 1px;
    }

    #pulseaudio, #network, #cpu, #memory, #disk, #battery, #custom-notification {
      padding-left: 5px;
      padding-right: 5px;
      margin-right: 8px;
    }
  '';
}
