{den, ...}: {
  # Graphical apps and theming that work on any OS with a screen. The Linux
  # session (bundles.desktop) and the mac (mba) both include this.
  den.aspects.bundles.gui.includes = [
    den.aspects.stylix
    den.aspects.zen
    den.aspects.apps
  ];

  den.aspects.bundles.gui.homeManager = {
    # Not for howard@vip: gl issues on non-NixOS.
    programs.ghostty.enable = true;
  };
}
