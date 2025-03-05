{
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf config.myGraphics.nvidia {
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package =
      if config.myGraphics.nvidiaVulkan
      then config.boot.kernelPackages.nvidiaPackages.vulkan_beta
      else config.boot.kernelPackages.nvidiaPackages.stable;
  };

  environment.systemPackages = with pkgs; [
    cudatoolkit
    (
      if config.myGraphics.nvidiaVulkan
      then linuxPackages.nvidia_x11_vulkan_beta
      else linuxPackages.nvidia_x11
    )
  ];

  hardware.nvidia-container-toolkit.enable = true;
}
