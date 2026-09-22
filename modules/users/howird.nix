{den, ...}: {
  den.aspects.howird.includes = [
    den.batteries.host-aspects
    den.aspects.stylix

    den.aspects.bundles.shell
    den.aspects.bundles.editors
    den.aspects.bundles.agents
    den.aspects.bundles.devtools
    den.aspects.bundles.docs
    den.aspects.bundles.personal

    # workstation-only (nixos-config-attached, not shared with howard@vip)
    den.aspects.niri
    den.aspects.noctalia
    den.aspects.kanshi
    den.aspects.record
    den.aspects.clipboard
    den.aspects.linux-apps
    den.aspects.granola
    den.aspects.chromium
    den.aspects.life
    den.aspects.gpg
    den.aspects.thunar
  ];

  den.aspects.howird.homeManager = {
    programs.niri.enable = true;
  };
}
