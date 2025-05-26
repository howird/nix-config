{pkgs, ...}: {
  imports = [
    ./style.nix
  ];
  home.packages = with pkgs; [
    swaynotificationcenter
    (writeShellScriptBin "record" (builtins.readFile ./record))
  ];
  xdg.configFile."swaync/config.json".source = ./config.json;
}
