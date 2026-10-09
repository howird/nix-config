{
  # Included by roles.workstation. Driven by the host facts `gpu` ("amd" |
  # "nvidia" | null) and `gpuVulkan` (nvidia vulkan-beta driver); with
  # `gpu = null` only the generic mesa setup applies.
  den.aspects.graphics.nixos = {
    host,
    lib,
    config,
    pkgs,
    ...
  }: {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    boot.initrd.kernelModules = lib.optionals (host.gpu == "amd") ["amdgpu"];
    boot.kernelModules = lib.optionals (host.gpu == "amd") ["kvm-amd"];

    services.xserver.videoDrivers = lib.optionals (host.gpu == "amd") ["amdgpu"] ++ lib.optionals (host.gpu == "nvidia") ["nvidia"];

    hardware.graphics.extraPackages = lib.optionals (host.gpu == "amd") (with pkgs; [
      rocmPackages.clr
      rocmPackages.clr.icd
      amdvlk
    ]);

    hardware.nvidia = lib.mkIf (host.gpu == "nvidia") {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = true;
      nvidiaSettings = true;
      package =
        if host.gpuVulkan
        then config.boot.kernelPackages.nvidiaPackages.vulkan_beta
        else config.boot.kernelPackages.nvidiaPackages.stable;
    };

    hardware.nvidia-container-toolkit.enable = host.gpu == "nvidia";

    environment.systemPackages = with pkgs;
      lib.optionals (host.gpu == "amd") [
        rocmPackages.rocminfo
        amdgpu_top
      ]
      ++ lib.optionals (host.gpu == "nvidia") [
        cudatoolkit
        (
          if host.gpuVulkan
          then linuxPackages.nvidia_x11_vulkan_beta
          else linuxPackages.nvidia_x11
        )
      ];
  };
}
