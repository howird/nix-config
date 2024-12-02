{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  boot.initrd.kernelModules = ["amdgpu"];
  boot.kernelModules = ["kvm-amd"];

  services.xserver.videoDrivers = ["amdgpu"];

  hardware.graphics.extraPackages = with pkgs; [
    rocmPackages.clr
    rocmPackages.clr.icd
    amdvlk
  ];
  environment.systemPackages = with pkgs; [
    rocmPackages.rocminfo
    amdgpu_top
  ];
}
