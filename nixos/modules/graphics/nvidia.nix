{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;
  };

  environment.systemPackages = with pkgs; [
    cudatoolkit
    linuxPackages.nvidia_x11
  ];

  hardware.nvidia-container-toolkit.enable = true;
}
