{config, ...}: {
  programs.waybar.style = let
    font = config.stylix.fonts.serif.name;
    font_weight = "bold";
    font_size = "18px";
    opacity = "1";

    colors = config.lib.stylix.colors.withHashtag;
    text = colors.base05;
    base = colors.base00;
    mantle = colors.base01;
    surface1 = colors.base03;
    green = colors.base0B;
  in ''
    * {
      border: none;
      border-radius: 0px;
      padding: 0;
      margin: 0;
      font-family: "${font}";
      font-weight: ${font_weight};
      opacity: ${opacity};
      font-size: ${font_size};
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
      color: ${text};
    }

    #workspaces {
      padding-left: 15px;
    }
    #workspaces button {
      color: ${text};
      padding-left:  5px;
      padding-right: 5px;
      margin-right: 10px;
    }
    #workspaces button.empty {
      color: ${text};
    }
    #workspaces button.active {
      color: ${green};
    }

    #clock {
      color: ${text};
    }

    #tray {
      margin-left: 10px;
      color: ${text};
    }
    #tray menu {
      background: ${mantle};
      border: 1px solid ${surface1};
      padding: 8px;
    }
    #tray menuitem {
      padding: 1px;
    }

    #pulseaudio, #network, #cpu, #memory, #disk, #battery, #custom-notification {
      padding-left: 5px;
      padding-right: 5px;
      margin-right: 10px;
      color: ${text};
    }

    #pulseaudio {
      margin-left: 15px;
    }

    #custom-notification {
      margin-left: 15px;
      padding-right: 2px;
      margin-right: 5px;
    }

    #custom-launcher {
      font-size: 20px;
      color: ${text};
      font-weight: bold;
      margin-left: 15px;
      padding-right: 10px;
    }
  '';
}
