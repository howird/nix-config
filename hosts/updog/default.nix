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

  programs.hyprland.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  boot.kernelParams = ["psmouse.synaptics_intertouch=0"];
}
