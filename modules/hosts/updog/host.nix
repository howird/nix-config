{inputs, ...}: {
  den.hosts.x86_64-linux.updog.users.howird = {};

  den.aspects.updog.nixos = {
    imports = [
      inputs.hardware.nixosModules.lenovo-thinkpad-t480s
      ./_hardware-configuration.nix
    ];

    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;

    boot.kernelParams = ["psmouse.synaptics_intertouch=0"];
  };
}
