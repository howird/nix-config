{pkgs, ...}: {
  home.packages = with pkgs; [
    hyprshot
    zenity
    wf-recorder
    (writeShellScriptBin "record" (builtins.readFile ./record))
  ];

  wayland.windowManager.hyprland.settings.bind = [
    "$mainMod ALT, S, exec, hyprshot -m output"
    "$shftMod ALT, S, exec, hyprshot -m region"
    "$mainMod, S, exec, hyprshot -m output --clipboard-only"
    "$shftMod, S, exec, hyprshot -m region --clipboard-only"
  ];
}
