{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; (lib.optionals (config.programs.hyprland.enable || config.programs.niri.enable) [
    zenity
    wf-recorder
    slurp
    wl-clipboard-rs
    (writeShellScriptBin "record" (builtins.readFile ./record))
  ]);
}
