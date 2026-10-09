{den, ...}: {
  # The graphical session: compositor, shell, greeter, theme, and the apps
  # that only make sense with a screen. Included by roles.workstation, not by
  # users, so a headless host never gets it.
  den.aspects.bundles.desktop.includes = [
    den.aspects.niri
    den.aspects.noctalia
    den.aspects.noctalia-greeter
    den.aspects.stylix
    den.aspects.kanshi
    den.aspects.record
    den.aspects.thunar
    den.aspects.life
    den.aspects.granola
    den.aspects.chromium
    den.aspects.zen
    den.aspects.linux-apps
  ];

  den.aspects.bundles.desktop.homeManager = {
    programs.niri.enable = true;
  };
}
