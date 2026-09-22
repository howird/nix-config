{...}: {
  # Low-battery warnings. Part of den.aspects.bundles.waybar-shell; noctalia's
  # battery service replaces it (`[battery] warning_threshold`).
  den.aspects.batsignal.homeManager = {
    services.batsignal = {
      enable = true;
      extraArgs = [
        "-c"
        "5"
        "-w"
        "20"
        "-f"
        "90"
      ];
    };
  };
}
