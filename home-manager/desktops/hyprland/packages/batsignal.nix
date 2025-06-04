{config, ...}: {
  services.batsignal = {
    enable = config.myDesktop == "hyprland";
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
