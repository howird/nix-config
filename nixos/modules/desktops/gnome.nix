{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf config.myDesktop.gnome {
  # X11 windowing system.
  services.xserver = {
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
    displayManager.gdm.wayland = true;
    excludePackages = [pkgs.xterm];
  };

  # Disable GNOME default applications
  # https://discourse.nixos.org/t/howto-disable-most-gnome-default-applications-and-what-they-are/13505
  environment.gnome.excludePackages = with pkgs.gnome; [
    epiphany # web browser
    yelp # help viewer
    geary # email client
    seahorse # password manager

    gnome-calculator
    gnome-calendar
    gnome-characters
    gnome-clocks
    gnome-contacts
    gnome-weather
    gnome-maps
    gnome-music
    pkgs.gnome-connections
    pkgs.gnome-tour
  ];
}
