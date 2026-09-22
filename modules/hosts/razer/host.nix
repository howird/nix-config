{
  inputs,
  den,
  ...
}: {
  den.hosts.x86_64-linux.razer.users.howird = {};

  den.aspects.razer.includes = [
    den.aspects.kanata
  ];

  den.aspects.razer.nixos = {
    imports = [
      inputs.hardware.nixosModules.common-cpu-intel
      inputs.hardware.nixosModules.common-pc-ssd
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
      kanata.keyboards.laptop.configFile = ../../../configs/keyboards/kanata/razer.kbd;
    };
  };

  den.aspects.razer.homeManager = {
    desktop.internalScale = 2.0;
  };
}
