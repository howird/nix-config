{...}: {
  # Reusable nixos/home-manager modules you might want to export to other
  # flakes. Nothing lives here yet (nothing consumes these outputs today),
  # kept only so the flake output shape doesn't change.
  flake = {
    nixosModules = {};
    homeManagerModules = {};
  };
}
