{den, ...}: {
  # Grouped by *who*, not *what*: the machines howird owns, as opposed to
  # the work box (howard@vip). Anything here is a thing those two machines
  # have and vip deliberately doesn't.
  den.aspects.bundles.personal.includes = [
    den.aspects.apps
    den.aspects.zen
    den.aspects.rclone
  ];

  den.aspects.bundles.personal.homeManager = {
    # Not enabled for howard@vip: gl issues on non-NixOS.
    programs.ghostty.enable = true;
  };
}
