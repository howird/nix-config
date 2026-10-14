{inputs, ...}: {
  den.aspects.doctools.homeManager = {pkgs, ...}: let
    stable = inputs.nixpkgs-stable.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  in {
    home.packages = with pkgs; [
      # zotero 10 targets gecko 140 (app/config.sh GECKO_VERSION_LINUX), but
      # unstable dropped esr 140 and builds it on esr 153, which breaks
      # fetch_xulrunner's ActorManagerParent edits. Feed it stable's esr 140.
      (zotero.override {firefox-esr-153-unwrapped = stable.firefox-esr-140-unwrapped;})
      pandoc
      pdftk
    ];
  };
}
