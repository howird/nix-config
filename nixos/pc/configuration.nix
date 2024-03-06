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

  networking.hostName = "nixwird-pc";

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };
}
