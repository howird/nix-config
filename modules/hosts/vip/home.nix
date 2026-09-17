{inputs, ...}: {
  flake-file.inputs.nixgl = {
    url = "github:nix-community/nixGL";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.flake-utils.follows = "flake-utils";
  };

  # den.homes standalone configs default to a plain, non-overlaid
  # `nixpkgs.legacyPackages.<system>` — override pkgs explicitly so
  # howard@vip gets the same overlays as before.
  den.homes.x86_64-linux."howard@vip".pkgs = import inputs.nixpkgs {
    system = "x86_64-linux";
    overlays = [
      inputs.nixgl.overlay
    ];
    config = {allowUnfree = true;};
  };
}
