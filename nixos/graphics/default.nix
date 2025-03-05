{lib, ...}: {
  imports = [
    ./amd.nix
    ./nvidia.nix
  ];

  options = {
    myGraphics = {
      amd = lib.mkEnableOption "amd";
      nvidia = lib.mkEnableOption "nvidia";
      nvidiaVulkan = lib.mkEnableOption "nvidia vulkan";
    };
  };
}
