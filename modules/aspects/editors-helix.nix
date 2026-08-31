{...}: {
  flake-file.inputs.helix-flake = {
    url = "github:mattwparas/helix/steel-event-system";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.rust-overlay.follows = "rust-overlay";
  };

  den.aspects.editors-helix.homeManager = {pkgs, ...}: {
    imports = [
      ./_editors-helix/languages/default.nix

      ./_editors-helix/helix.nix
      ./_editors-helix/binds.nix
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
