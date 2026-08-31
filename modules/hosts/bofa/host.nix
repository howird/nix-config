{
  inputs,
  den,
  ...
}: {
  den.hosts.x86_64-linux.bofa = {
    users.howird = {};
    gpu = "nvidia";
    gpuVulkan = true;
  };

  den.aspects.bofa.includes = [
    den.aspects.graphics
    den.aspects.llms
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

    services.openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
        X11Forwarding = true;
      };
    };

    environment.systemPackages = with pkgs; [
      lm_sensors
      vulkan-loader
      vulkan-tools
    ];
  };
}
