{
  lib,
  config,
  pkgs,
  ...
}: let
  hyprland = config.programs.hyprland.enable;
  niri = config.programs.niri.enable;
  either = hyprland || niri;
in {
  services.displayManager.gdm = {
    enable = either || config.services.desktopManager.gnome.enable;
    wayland = either || config.services.desktopManager.gnome.enable;
  };

  services.gnome.gnome-keyring.enable = either;
  security.pam.services.gdm.enableGnomeKeyring = either;
  programs.seahorse.enable = either;

  xdg.portal = {
    enable = either;
    wlr.enable = either;
    xdgOpenUsePortal = either;
    config = {
      common.default = ["gtk"];
      hyprland.default = ["gtk" "hyprland"];
      niri.default = ["gtk" "gnome"];
    };
    extraPortals = with pkgs; (
      (lib.optionals either [xdg-desktop-portal xdg-desktop-portal-gtk kdePackages.xdg-desktop-portal-kde])
      ++ lib.optional niri xdg-desktop-portal-gnome
      ++ lib.optional hyprland xdg-desktop-portal-hyprland
    );
  };
}
