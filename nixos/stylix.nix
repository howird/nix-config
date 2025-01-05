{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest-dark-hard.yaml";

    image = config.myWallpaper;
    polarity = "dark";
    opacity.terminal = 0.75;

    cursor.package = pkgs.bibata-cursors;
    cursor.name = "Bibata-Original-Ice";
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    maple-mono-NF
    aleo-fonts
  ];

  stylix.fonts = rec {
    serif = {
      package = pkgs.aleo-fonts;
      name = "Aleo";
    };

    sansSerif = serif;

    monospace = {
      # package = pkgs.nerd-fonts.jetbrains-mono;
      # name = "JetBrainsMono NF";
      package = pkgs.maple-mono-NF;
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
}
