{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.framework-13-7040-amd
    ./hardware-configuration.nix
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.logind = {
    lidSwitch = "suspend-then-hibernate";
    extraConfig = ''
      HandlePowerKey=suspend-then-hibernate
      IdleAction=suspend-then-hibernate
      IdleActionSec=2m
    '';
  };
  systemd.sleep.extraConfig = "HibernateDelaySec=1h";

  services.kanata.enable = true;
  services.kanata.keyboards.laptop.configFile = ../../configs/keyboards/kanata/framework.kbd;
  # services.kanata.keyboards.foldable.configFile = ../../configs/keyboards/kanata/protoarc.kbd;
  # services.udev.extraRules = ''
  #   SUBSYSTEM=="input", KERNEL=="event*", ENV{LIBINPUT_DEVICE_GROUP}=="5/3554/f605:2c:98:11:3d:41:26", SYMLINK+="input/protoarc-kbd"
  # '';
}
