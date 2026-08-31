{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = lib.optionals config.programs.niri.enable (with pkgs; [
    zenity
    wf-recorder
    slurp
    wl-clipboard-rs
    (writeShellScriptBin "record" (builtins.readFile ./record))
  ]);
}
