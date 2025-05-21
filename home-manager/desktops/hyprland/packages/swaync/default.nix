{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    swaynotificationcenter
    (writeShellScriptBin "record" (builtins.readFile ./record))
  ];
  xdg.configFile."swaync/config.json".source = ./config.json;
  xdg.configFile."swaync/style.css".text = import ./style.nix {
    font = config.stylix.fonts.serif.name;

    text = "#${config.lib.stylix.colors.base05}";
    base = "#${config.lib.stylix.colors.base00}";
    mantle = "#${config.lib.stylix.colors.base01}";
    surface0 = "#${config.lib.stylix.colors.base02}";
    surface1 = "#${config.lib.stylix.colors.base03}";
    surface2 = "#${config.lib.stylix.colors.base04}";
    green = "#${config.lib.stylix.colors.base0B}";
  };
}
