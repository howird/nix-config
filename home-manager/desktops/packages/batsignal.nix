{config, ...}: {
  services.batsignal = {
    enable = config.wayland.windowManager.hyprland.enable;
    extraArgs = [
      "-c"
      "5"
      "-w"
      "20"
      "-f"
      "90"
    ];
  };
}
