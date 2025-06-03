{...}: {
  imports = [
    ../../home-manager
    ../../home-manager/nixos-only.nix
  ];
  config = {
    wayland.windowManager.hyprland.settings.monitor = [
      "eDP-1, 2256x1504, 0x0, 1.6" # main screen
      "DP-10, 2560x1080, 0x-1080, 1.0" # LG ultrawide
      "DP-11, 1920x1080, 320x-2160, 1.0" # dell
    ];
    home.sessionVariables.GDK_SCALE = "1.6";
  };
}
