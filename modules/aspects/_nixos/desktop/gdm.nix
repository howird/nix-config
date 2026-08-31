{
  lib,
  config,
  pkgs,
  ...
}: {
  services.displayManager.gdm.enable = config.programs.niri.enable || config.services.desktopManager.gnome.enable;
  services.gnome.gnome-keyring.enable = config.programs.niri.enable;

  security.pam.services.gdm.enableGnomeKeyring = config.programs.niri.enable;
  programs.seahorse.enable = config.programs.niri.enable;

  xdg.portal = {
    # Unconditional: services.flatpak (enabled for every host) asserts on this
    # regardless of niri. The rest of the block stays niri-gated as before.
    enable = true;
    wlr.enable = config.programs.niri.enable;
    xdgOpenUsePortal = config.programs.niri.enable;
    config = {
      common.default = ["gtk"];
      niri.default = ["gtk" "gnome"];
    };
    extraPortals = with pkgs;
      [xdg-desktop-portal xdg-desktop-portal-gtk]
      ++ lib.optionals config.programs.niri.enable [xdg-desktop-portal-gnome];
  };
}
