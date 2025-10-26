{
  lib,
  config,
  pkgs,
  ...
}: {
  services.displayManager.gdm = {
    enable = config.programs.niri.enable || config.services.desktopManager.gnome.enable;
    wayland = config.programs.niri.enable || config.services.desktopManager.gnome.enable;
  };

  services.gnome.gnome-keyring.enable = config.programs.niri.enable;
  security.pam.services.gdm.enableGnomeKeyring = config.programs.niri.enable;
  programs.seahorse.enable = config.programs.niri.enable;

  xdg.portal = {
    enable = config.programs.niri.enable;
    wlr.enable = config.programs.niri.enable;
    xdgOpenUsePortal = config.programs.niri.enable;
    config = {
      common.default = ["gtk"];
      niri.default = ["gtk" "gnome"];
    };
    extraPortals = lib.optionals config.programs.niri.enable (with pkgs; [
      xdg-desktop-portal
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
      kdePackages.xdg-desktop-portal-kde
    ]);
  };
}
