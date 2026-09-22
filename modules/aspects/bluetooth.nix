{...}: {
  den.aspects.bluetooth.nixos = {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    services.blueman.enable = true;
  };

  den.aspects.bluetooth.homeManager = {
    config,
    lib,
    pkgs,
    ...
  }:
    lib.mkIf config.programs.niri.enable {
      # blueman-applet (spawned below) and blueman-manager (the pairing
      # window it opens).
      home.packages = [pkgs.blueman];

      # Gated on niri because this is niri's startup list; the package above
      # rides along with it for the same reason.
      programs.niri.settings.spawn-at-startup = [
        {argv = ["blueman-applet"];}
      ];
    };
}
