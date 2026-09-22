{
  inputs,
  den,
  ...
}: {
  den.hosts.x86_64-linux.yerm.users.howird = {};

  den.aspects.yerm.includes = [
    den.aspects.kanata
  ];

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
      kanata.keyboards.laptop.configFile = ../../../configs/keyboards/kanata/framework.kbd;
      # kanata.keyboards.foldable.configFile = ../../../configs/keyboards/kanata/protoarc.kbd;
    };
  };

  den.aspects.yerm.homeManager = {
    desktop.internalScale = 1.6;
  };
}
