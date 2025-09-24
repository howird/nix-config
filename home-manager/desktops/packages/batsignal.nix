{config, ...}: {
  services.batsignal = {
    enable = config.programs.hyprland.enable || config.programs.niri.enable;
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
