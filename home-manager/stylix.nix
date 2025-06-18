{
  lib,
  config,
  pkgs,
  ...
}: {
  options = with lib; {
    myWallpaper = mkOption {
      type = types.path;
      default = let
        catppuccin-wallpapers = pkgs.fetchFromGitHub {
          owner = "zhichaoh";
          repo = "catppuccin-wallpapers";
          rev = "1023077979591cdeca76aae94e0359da1707a60e";
          sha256 = "sha256-h+cFlTXvUVJPRMpk32jYVDDhHu1daWSezFcvhJqDpmU=";
        };
      in "${catppuccin-wallpapers}/misc/lonely-fish.png";
      description = "Wallpaper filename.";
    };
    myTheme = mkOption {
      type = types.str;
      default = "catppuccin-mocha";
      description = "Theme name, must be in base16Schemes";
    };
  };

  config = {
    myTheme = "everforest-dark-hard";
    myWallpaper = ./desktops/wallpapers/pokemon-concierge.png;

    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/${config.myTheme}.yaml";

      image = config.myWallpaper;
      polarity = "dark";
      opacity.terminal = 0.75;

      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Original-Ice";
        size = 24;
      };
    };

    stylix.fonts = rec {
      serif = {
        package = pkgs.aleo-fonts;
        name = "Aleo";
      };

      sansSerif = serif;

      monospace = {
        # package = pkgs.nerd-fonts.jetbrains-mono;
        # name = "JetBrainsMono NF";
        package = pkgs.maple-mono.NF;
        name = "Maple Mono NF";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };

      sizes = let
        fontSize = 12;
      in {
        applications = fontSize;
        desktop = fontSize;
        popups = fontSize;
        terminal = fontSize;
      };
    };
  };
}
