{
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf config.myDesktop.hyprland {
  services.displayManager.gdm.enable = true;
  services.displayManager.gdm.wayland = true;

  # run directly from tty without display manager
  # services.displayManager.enable = lib.mkForce false;
  # services.displayManager.lightdm.enable = false;

  programs.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
  };

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.gdm.enableGnomeKeyring = true;
  programs.seahorse.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };
}
