{
  inputs,
  lib,
  ...
}: {
  flake-file.description = "Howard's dendritic NixOS + home-manager configuration, using Den";

  imports = [
    (inputs.flake-file.flakeModules.dendritic or {})
    (inputs.den.flakeModules.dendritic or {})
  ];

  den.systems = ["x86_64-linux" "aarch64-linux"];

  # Every user we declare wants a home-manager environment.
  den.schema.user.classes = lib.mkDefault ["homeManager"];

  # Only genuinely foundational inputs with no single owning aspect live here.
  # Everything else is declared via `flake-file.inputs.<name>` right next to
  # the aspect file that actually consumes it.
  flake-file.inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-26.05";
    hardware.url = "github:nixos/nixos-hardware"; # used by hosts/{yerm,updog,bofa}/host.nix
    flake-utils.url = "github:numtide/flake-utils";
    crane.url = "github:ipetkov/crane";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
