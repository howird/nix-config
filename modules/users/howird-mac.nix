{den, ...}: {
  den.aspects.howird-mac.includes = [
    den.batteries.define-user
    den.batteries.primary-user
    (den.batteries.user-shell "zsh")
    den.aspects.stylix

    den.aspects.bundles.shell
    den.aspects.bundles.editors
    den.aspects.bundles.agents
    den.aspects.bundles.devtools
    den.aspects.bundles.docs
    den.aspects.bundles.personal

    den.aspects.apps
    den.aspects.zen
    den.aspects.syncthing
  ];

  den.aspects.howird-mac.homeManager = {
    lib,
    pkgs,
    ...
  }: {
    home.username = lib.mkForce "howird";

    programs.ghostty.package = pkgs.ghostty-bin;
  };
}
