{pkgs, ...}: {
  home.packages = with pkgs; [
    hyprshot
    (writeShellScriptBin "record" (builtins.readFile ./record))
    zenity
  ];
}
