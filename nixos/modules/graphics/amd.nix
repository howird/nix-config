{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  boot.initrd.kernelModules = ["amdgpu"];

  services.xserver.videoDrivers = ["amdgpu"];

  hardware.graphics.extraPackages = with pkgs; [
    rocmPackages.clr
    rocmPackages.clr.icd
    amdvlk
  ];
  environment.systemPackages = with pkgs; [
    amdgpu_top
  ];
}
