{pkgs, ...}: {
  home.packages = with pkgs; [
    hyprshot
    zenity
    wf-recorder
    (writeShellScriptBin "record" (builtins.readFile ./record))
  ];
}
