{inputs, den, ...}: {
  flake-file.inputs.nixgl = {
    url = "github:nix-community/nixGL";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.flake-utils.follows = "flake-utils";
  };

  # sshd is managed outside Nix on this standalone host.
  den.homes.x86_64-linux."howard@vip".aspect = {
    includes = [den.aspects.howard];
    homeManager.programs.zellij.webServer.enable = true;
  };

  # den.homes standalone configs default to a plain, non-overlaid
  # `nixpkgs.legacyPackages.<system>` — override pkgs explicitly so
  # howard@vip gets the same overlays as before.
  den.homes.x86_64-linux."howard@vip".pkgs = import inputs.nixpkgs {
    system = "x86_64-linux";
    overlays = [
      inputs.nixgl.overlay
      inputs.helix-plugins.overlays.default
    ];
    config = {allowUnfree = true;};
  };
}
