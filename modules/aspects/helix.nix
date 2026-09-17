{...}: {
  # flake-file.inputs.helix-flake = {
  #   url = "github:mattwparas/helix/steel-event-system";
  #   inputs.nixpkgs.follows = "nixpkgs";
  # };

  den.aspects.helix.homeManager = _: {
    imports = [
      ./_helix/languages/default.nix

      ./_helix/helix.nix
      ./_helix/binds.nix
    ];

    programs.helix = {
      defaultEditor = true;
      # package = inputs.helix-flake.packages.${pkgs.system}.default.overrideAttrs (oldAttrs: {
      #   cargoBuildFlags = (oldAttrs.cargoBuildFlags or []) ++ ["--features" "steel,git"];
      # });
      # extraPackages = with pkgs; [steel];
    };

    programs.yazi.enable = true;
  };
}
