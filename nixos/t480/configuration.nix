# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "nixwird-t480";

  boot.kernelParams = [ "psmouse.synaptics_intertouch=0" ];
}
