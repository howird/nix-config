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

  # Need the latest kernel for WiFi support on Framework
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixwird-framework";

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
}
