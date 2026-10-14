{inputs, ...}: {
  flake-file.inputs.helix-flake = {
    url = "github:mattwparas/helix/steel-event-system";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.helix.homeManager = {pkgs, ...}: {
    imports = [
      ./_helix/languages

      ./_helix/helix.nix
      ./_helix/binds.nix
    ];

    programs.helix = {
      defaultEditor = true;
      package =
        (
          inputs.helix-flake.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
            # glibc 2.44 makes bsearch a C23 _Generic macro, which breaks the perl
            # grammar's own bsearch definition; gnu17 keeps the plain prototype.
            grammarOverlays = [
              (_: prev: {
                perl = prev.perl.overrideAttrs (o: {FLAGS = o.FLAGS ++ ["-std=gnu17"];});
              })
            ];
          }
        ).overrideAttrs (oldAttrs: {
          cargoBuildFlags = (oldAttrs.cargoBuildFlags or []) ++ ["--features" "steel,git"];
        });
      extraPackages = with pkgs; [steel];
    };

    programs.yazi.enable = true;
  };
}
