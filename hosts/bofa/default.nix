{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  host,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-pc-ssd
    inputs.vscode-server.nixosModules.default

    ./hardware-configuration.nix
    ../../nixos/graphics/nvidia.nix
    # ../../nixos/graphics/amd.nix
    ../../nixos/llms.nix
  ];

  services.syncthing.enable = true;
  myDesktop.hyprland = true;

  # GPU STUFF
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
