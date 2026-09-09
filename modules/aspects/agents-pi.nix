{inputs, ...}: {
  flake-file.inputs.pi = {
    url = "github:lukasl-dev/pi.nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.agents-pi.homeManager = {pkgs, ...}: let
    inherit (pkgs.stdenv.hostPlatform) system;
  in {
    imports = [
      ./_agents-pi/bindings.nix
      ./_agents-pi/settings.nix
    ];

    programs.pi-coding-agent = {
      enable = true;
      package = inputs.pi.packages.${system}.default;
    };
  };
}
