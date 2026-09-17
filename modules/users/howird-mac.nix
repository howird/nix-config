{den, ...}: {
  den.aspects.howird-mac.includes = [
    den.aspects.stylix

    den.aspects.bundles.shell
    den.aspects.bundles.editors
    den.aspects.bundles.agents
    den.aspects.bundles.devtools
    den.aspects.bundles.docs
    den.aspects.bundles.personal

    den.aspects.mac-apps
  ];

  den.aspects.howird-mac.homeManager = {
    lib,
    pkgs,
    ...
  }: {
    home.username = lib.mkForce "howird";
    home.homeDirectory = lib.mkForce "/Users/howird";

    programs.ghostty.package = pkgs.ghostty-bin;
  };
}
