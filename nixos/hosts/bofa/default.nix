{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-pc-ssd
    inputs.vscode-server.nixosModules.default
    ./hardware-configuration.nix
    ../../modules/graphics/nvidia.nix
    ../../modules/graphics/amd.nix
  ];

  # GPU STUFF
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  networking.hostName = "bofa";

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };
  environment.systemPackages = with pkgs; [
    lm_sensors
    vulkan-tools
  ];
  services.vscode-server.enable = true;
  services.vscode-server.nodejsPackage = pkgs.nodejs-18_x;
}