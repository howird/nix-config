{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [ ./cuda-maintainers.nix ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  environment.systemPackages = with pkgs; [
    cudatoolkit
    linuxPackages.nvidia_x11
  ];

  virtualisation.docker.enableNvidia = true;
}
