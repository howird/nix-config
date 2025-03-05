{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-pc-ssd
    inputs.vscode-server.nixosModules.default
    ../../nixos/graphics

    ./hardware-configuration.nix
    ../../nixos/llms.nix
  ];

  services.syncthing.enable = true;
  services.glances.enable = true;
  services.ollama.enable = true;
  services.open-webui.enable = true;

  myDesktop.hyprland = true;

  # GPU STUFF
  myGraphics.amd = false;
  myGraphics.nvidia = true;
  # myGraphics.nvidiaVulkan = true;
  # boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_6; # TODO: for nvidia vulkan

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
  services.vscode-server.enable = true;
}
