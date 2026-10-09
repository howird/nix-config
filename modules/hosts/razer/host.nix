{
  inputs,
  den,
  ...
}: {
  den.hosts.x86_64-linux.razer = {
    users.howird = {};
    keymap = "razer";
    internalScale = 2.0;
  };

  den.aspects.razer.includes = [
    den.aspects.roles.workstation
    den.aspects.roles.laptop
  ];

  den.aspects.razer.nixos = {
    imports = [
      inputs.hardware.nixosModules.common-cpu-intel
      inputs.hardware.nixosModules.common-pc-ssd
      ./_hardware-configuration.nix
    ];
  };
}
