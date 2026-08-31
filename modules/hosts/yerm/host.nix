{inputs, ...}: {
  den.hosts.x86_64-linux.yerm.users.howird = {};

  den.aspects.yerm.nixos = {
    imports = [
      inputs.hardware.nixosModules.framework-13-7040-amd
      ./_hardware-configuration.nix
    ];

    programs.niri.enable = true;

    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };
      bluetooth.enable = true;
      bluetooth.powerOnBoot = true;
    };

    services = {
      syncthing.enable = true;
      upower.enable = true;
      kanata = {
        enable = true;
        keyboards.laptop.configFile = ../../../configs/keyboards/kanata/framework.kbd;
        # keyboards.foldable.configFile = ../../../configs/keyboards/kanata/protoarc.kbd;
      };
    };
  };

  # Projected onto howird via den.batteries.host-aspects (see modules/users/howird.nix).
  den.aspects.yerm.homeManager = {
    home.sessionVariables.GDK_SCALE = "1.6";

    programs.niri.settings.spawn-at-startup = [
      {argv = ["nm-applet"];}
      {argv = ["poweralertd"];}
      {argv = ["blueman-applet"];}
    ];
  };
}
