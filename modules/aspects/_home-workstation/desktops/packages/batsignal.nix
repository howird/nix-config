{config, ...}: {
  services.batsignal = {
    inherit (config.programs.niri) enable;
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
