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
  };

  config = {
    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

      image = config.myWallpaper;
      polarity = "dark";
      opacity.terminal = 0.75;

      cursor.package = pkgs.bibata-cursors;
      cursor.name = "Bibata-Original-Ice";
      cursor.size = 24;
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
