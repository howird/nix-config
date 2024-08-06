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

  programs.dconf.enable = true;

  # Disable GNOME default applications
  # https://discourse.nixos.org/t/howto-disable-most-gnome-default-applications-and-what-they-are/13505
  environment.gnome.excludePackages =
    (with pkgs; [
      epiphany # web browser
      geary # email reader
      seahorse # password manager
      yelp # Help view
      gnome-tour
      gnome-photos
      gnome-calendar
      gnome-connections
    ])
    ++ (with pkgs.gnome; [
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game

      gnome-maps
      gnome-music
      gnome-clocks
      gnome-weather
      gnome-contacts
      gnome-characters
      gnome-initial-setup
    ]);
}
