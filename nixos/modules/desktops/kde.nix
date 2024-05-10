{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  config = let
    enable = config.myDesktop == "kde";
  in {
    services.desktopManager.plasma6.enable = enable;
    services.displayManager.sddm = {
      enable = enable;
      wayland.enable = enable;
    };
  };
}
