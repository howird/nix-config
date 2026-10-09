{
  inputs,
  den,
  ...
}: {
  den.hosts.x86_64-linux.bofa = {
    users.howird = {};
    gpu = "nvidia";
    gpuVulkan = true;
    syncthing.id = "BP3NP5F-OHLLWR3-RY5NCR4-ADNXU3O-6J3TSBF-XZAIBF6-A3UVGKG-AQXHMQ4";
  };

  den.aspects.bofa.includes = [
    den.aspects.roles.workstation
    den.aspects.roles.server
    den.aspects.graphics
    den.aspects.llms
    den.aspects.paseo
    den.aspects.paseo-daemon
  ];

  den.aspects.bofa.nixos = {pkgs, ...}: {
    imports = [
      inputs.hardware.nixosModules.common-cpu-amd
      inputs.hardware.nixosModules.common-pc-ssd
      ./_hardware-configuration.nix
    ];

    services.syncthing.enable = true;
    services.glances.enable = false;
    services.ollama.enable = false;
    services.open-webui.enable = false;

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    environment.systemPackages = with pkgs; [
      lm_sensors
      vulkan-loader
      vulkan-tools
    ];
  };
}
