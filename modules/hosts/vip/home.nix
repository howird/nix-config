{inputs, ...}: {
  # den.homes standalone configs default to a plain, non-overlaid
  # `nixpkgs.legacyPackages.<system>` — override pkgs explicitly so
  # howard@vip gets the same custom packages + overlays as before.
  den.homes.x86_64-linux."howard@vip".pkgs = import inputs.nixpkgs {
    system = "x86_64-linux";
    overlays = [
      inputs.self.overlays.default
      inputs.rust-overlay.overlays.default
      inputs.nixgl.overlay
    ];
    config = {allowUnfree = true;};
  };
}
