{
  lib,
  config,
  pkgs,
  ...
}: let
  kde = config.services.desktopManager.plasma6.enable;
in {
  services.displayManager.sddm = {
    enable = kde;
    wayland.enable = kde;
    theme = "reactionary";
  };
  environment.plasma6.excludePackages = [];

  # partition-manager, remember to run as root: `sudo partitionmanager`
  programs.partition-manager.enable = kde;

  environment.systemPackages = with pkgs; (lib.optionals kde [
    exfatprogs # for partition-manager

    # kdePackages.kio-gdrive

    kdePackages.plasma-nm
    kdePackages.networkmanager-qt
    networkmanager-openvpn
    networkmanager-openconnect
    kdePackages.sddm-kcm

    posy-cursors
    commonality-theme
    reactionary-theme
    expose-theme
    kde-compact-pager
    kdePackages.qtmultimedia
    kde-fokus
  ]);
}
