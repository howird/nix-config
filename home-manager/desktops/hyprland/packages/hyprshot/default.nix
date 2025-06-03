{pkgs, ...}: {
  home.packages = with pkgs; [
    hyprshot
    zenity
    (writeShellScriptBin "record" (builtins.readFile ./record))
  ];
}
