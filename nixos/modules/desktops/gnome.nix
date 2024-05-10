{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  config = let 
    enable = config.myDesktop == "gnome";
  in {
    # X11 windowing system.
    services.xserver = {
      desktopManager.gnome.enable = enable;
      displayManager.gdm.enable = enable;
      displayManager.gdm.wayland = enable;
      excludePackages = if enable then [ pkgs.xterm ] else [];
    };

    # Disable GNOME default applications
    # https://discourse.nixos.org/t/howto-disable-most-gnome-default-applications-and-what-they-are/13505
    environment.gnome.excludePackages = if enable then with pkgs.gnome; [
      epiphany    # web browser
      yelp        # help viewer
      geary       # email client
      seahorse    # password manager

      gnome-calculator gnome-calendar gnome-characters gnome-clocks gnome-contacts
      gnome-weather gnome-maps gnome-music pkgs.gnome-connections pkgs.gnome-tour
    ] else [];
  };
}
