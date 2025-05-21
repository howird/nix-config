{config, ...}: let
  custom = {
    font = config.stylix.fonts.serif.name;
    font_weight = "bold";
    font_size = "18px";

    text = "#${config.lib.stylix.colors.base05}";
    base = "#${config.lib.stylix.colors.base00}";
    mantle = "#${config.lib.stylix.colors.base01}";
    surface1 = "#${config.lib.stylix.colors.base03}";
    peach = "#${config.lib.stylix.colors.base09}";
    yellow = "#${config.lib.stylix.colors.base0A}";

    opacity = "1";
    indicator_height = "2px";
  };
in {
  programs.waybar.style = with custom; ''
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
      border-top: 1px solid ${surface1};
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
      color: #${yellow};
      padding-left:  5px;
      padding-right: 5px;
      margin-right: 10px;
    }
    #workspaces button.empty {
      color: ${text};
    }
    #workspaces button.active {
      color: #${peach};
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
