{
  inputs,
  outputs,
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
    };
    environment.plasma6.excludePackages = [];
  };
}
