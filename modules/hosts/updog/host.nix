{
  inputs,
  den,
  ...
}: {
  den.hosts.x86_64-linux.updog.users.howird = {};

  den.aspects.updog.includes = [
    den.aspects.bluetooth
  ];

  den.aspects.updog.nixos = {
    imports = [
      inputs.hardware.nixosModules.lenovo-thinkpad-t480s
      ./_hardware-configuration.nix
    ];

    boot.kernelParams = ["psmouse.synaptics_intertouch=0"];
  };
}
