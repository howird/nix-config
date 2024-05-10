{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    libsForQt5.qtwayland
  ];
}
