{
  inputs,
  den,
  ...
}: {
  den.hosts.x86_64-linux.yerm = {
    users.howird = {};
    keymap = "framework";
    internalScale = 1.6;
    syncthing.id = "RBMEI57-GJNYWOV-QU5RHAX-HQSRD7Q-3SYCAG2-KVALZXA-5NP7VMA-V7N3ZA4";
  };

  den.aspects.yerm.includes = [
    den.aspects.roles.workstation
    den.aspects.roles.laptop
    den.aspects.kanata
    den.aspects.paseo
  ];

  den.aspects.yerm.nixos = {
    imports = [
      inputs.hardware.nixosModules.framework-13-7040-amd
      ./_hardware-configuration.nix
    ];

    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };
    };

    services = {
      syncthing.enable = true;
      kanata.keyboards.laptop.configFile = ../../../configs/keyboards/kanata/framework.kbd;
      # kanata.keyboards.foldable.configFile = ../../../configs/keyboards/kanata/protoarc.kbd;
    };
  };

  den.aspects.yerm.homeManager = {
    desktop.internalScale = 1.6;
    # fprintd itself comes from the nixos-hardware framework module
    programs.noctalia.settings.lockscreen.fingerprint = true;
  };
}
