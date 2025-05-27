{
  lib,
  config,
  pkgs,
  ...
}: {
  config = lib.mkIf config.myDesktop.kde {
    services.desktopManager.plasma6.enable = true;
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "reactionary";
    };
    environment.plasma6.excludePackages = [];

    # partition-manager, remember to run as root: `sudo partitionmanager`
    programs.partition-manager.enable = true;

    environment.systemPackages = with pkgs; [
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
    ];
  };
}
