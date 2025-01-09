{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf config.myDesktop.hyprland {
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;

  # run directly from tty without display manager
  # services.displayManager.enable = lib.mkForce false;
  # services.xserver.displayManager.lightdm.enable = false;

  programs.hyprland = {
    enable = true;
    # package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    xwayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}
