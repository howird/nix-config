{
  inputs,
  den,
  lib,
  ...
}: {
  flake-file.description = "Howard's dendritic NixOS + home-manager configuration, using Den";

  imports = [
    (inputs.flake-file.flakeModules.dendritic or {})
    (inputs.den.flakeModules.dendritic or {})
  ];

  den.systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin"];

  den.schema.user.classes = lib.mkDefault ["homeManager"];

  den.policies.host-guards = {host ? {}, ...}: [
    (den.lib.policy.resolve {
      isNixos = (host.class or null) == "nixos";
      isDarwin = (host.class or null) == "darwin";
    })
  ];
  den.default.includes = [den.policies.host-guards];

  flake-file.inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-26.05";
    hardware.url = "github:nixos/nixos-hardware";
    flake-utils.url = "github:numtide/flake-utils";
    crane.url = "github:ipetkov/crane";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
