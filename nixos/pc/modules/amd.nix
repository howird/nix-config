{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  boot.initrd.kernelModules = [ "amdgpu" ];

  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.opengl.extraPackages = with pkgs.rocmPackages; [
    clr
    clr.icd
  ];
  environment.systemPackages = with pkgs; [
    amdgpu_top
  ];
}
