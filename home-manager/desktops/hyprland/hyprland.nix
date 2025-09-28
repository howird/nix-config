{
  config,
  pkgs,
  lib,
  ...
}: let
  hyprland = config.programs.hyprland.enable;
in {
  systemd.user.targets.hyprland-session.Unit.Wants = lib.optional hyprland "xdg-desktop-autostart.target";

  wayland.windowManager.hyprland = {
    enable = hyprland;
    xwayland = {
      enable = true;
    };
    systemd.enable = true;
    systemd.variables = ["--all"];
    # plugins = with pkgs; [
    #   hyprscrolling
    #   hyprexpo
    # ];
  };
}
