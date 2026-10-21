{den, ...}: {
  # Graphical apps and theming that work on any OS with a screen. The Linux
  # session (the desktop bundle) and the mac (mba) both include this; a host
  # without it gets only the users' terminal tooling.
  den.aspects.gui.includes = [
    den.aspects.stylix
    den.aspects.zen
    den.aspects.apps
    den.aspects.ghostty
    den.aspects.vscode
    den.aspects.zed
    den.aspects.claude-desktop
    den.aspects.paseo-desktop
  ];
}
