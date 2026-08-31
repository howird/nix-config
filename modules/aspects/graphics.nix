{...}: {
  # Host-driven: set `den.hosts.<system>.<name>.gpu = "amd" | "nvidia";` (and
  # `.gpuVulkan = true;` for the nvidia vulkan-beta driver) on the host entity,
  # then `includes = [ den.aspects.graphics ];` on that host, instead of the
  # old `myGraphics.{amd,nvidia,nvidiaVulkan}` option flags.
  den.aspects.graphics.nixos = {
    host,
    lib,
    config,
    pkgs,
    ...
  }: {
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
        if host.gpuVulkan or false
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
          if host.gpuVulkan or false
          then linuxPackages.nvidia_x11_vulkan_beta
          else linuxPackages.nvidia_x11
        )
      ];
  };
}
