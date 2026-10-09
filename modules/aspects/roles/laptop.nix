{den, ...}: {
  den.aspects.roles.laptop.includes = [
    den.aspects.bluetooth
  ];

  den.aspects.roles.laptop.nixos = {
    services.upower.enable = true;
  };
}
