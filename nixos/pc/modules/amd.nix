{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  boot.initrd.kernelModules = [ "amdgpu" ];

  hardware.opengl.extraPackages = with pkgs.rocmPackages; [
    clr
    clr.icd
  ];
}
