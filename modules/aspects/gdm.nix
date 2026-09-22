{...}: {
  den.aspects.gdm.nixos = {
    lib,
    config,
    pkgs,
    ...
  }: {
    # Kept, but stood down: ./noctalia-greeter.nix now claims the same hosts,
    # and two display managers cannot both own vt1. Drop the greeter clause
    # here (or disable that aspect) and gdm comes back as it was.
    services.displayManager.gdm.enable =
      (config.programs.niri.enable || config.services.desktopManager.gnome.enable)
      && !config.services.displayManager.noctalia-greeter.enable;

    services.gnome.gnome-keyring.enable = config.programs.niri.enable;

    # Follows gdm rather than niri: with gdm off this pam stanza is a file
    # nothing reads, and the greeter aspect sets the greetd one instead.
    security.pam.services.gdm.enableGnomeKeyring = config.services.displayManager.gdm.enable;
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
  };
}
