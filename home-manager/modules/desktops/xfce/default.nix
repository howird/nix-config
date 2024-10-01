{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  config = lib.mkIf (config.myDesktop.xfce && !config.myDesktop.kde) {
    home.packages = with pkgs; [
      gnome.networkmanager-openvpn
      gnome.networkmanager-openconnect
    ];

    programs.gpg.enable = true;
    services.gpg-agent.enable = true;
  };
}
