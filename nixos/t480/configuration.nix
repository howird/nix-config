{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.lenovo-thinkpad-t480s
    ./hardware-configuration.nix
  ];

  networking.hostName = "nixwird-t480";

  boot.kernelParams = [ "psmouse.synaptics_intertouch=0" ];
}
