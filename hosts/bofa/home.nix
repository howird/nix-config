{
  imports = [
    ../../home-manager
    ../../home-manager/nixos-only.nix
  ];
  config = {
    programs.hyprland.enable = true;
    programs.niri.enable = true;

    wayland.windowManager.hyprland.settings.monitor = [
      "HDMI-A-1, 1920x1080@60, 0x0, 1"
    ];
  };
}
