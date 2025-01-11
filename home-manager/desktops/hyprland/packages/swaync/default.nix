{pkgs, ...}: {
  home.packages = with pkgs; [
    swaynotificationcenter
    (writeShellScriptBin "record" (builtins.readFile ./record))
  ];
  xdg.configFile."swaync/style.css".source = ./style.css;
  xdg.configFile."swaync/config.json".source = ./config.json;
}
