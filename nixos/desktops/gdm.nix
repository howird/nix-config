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
    enable = either;
    wayland = either;
  };

  services.gnome.gnome-keyring.enable = either;
  security.pam.services.gdm.enableGnomeKeyring = either;
  programs.seahorse.enable = either;

  xdg.portal = {
    enable = either;
    wlr.enable = either;
    xdgOpenUsePortal = either;
    extraPortals = with pkgs; (
      (lib.optionals either [xdg-desktop-portal-hyprland xdg-desktop-portal-gtk])
      ++ lib.optional niri xdg-desktop-portal-gnome
    );
  };
}
