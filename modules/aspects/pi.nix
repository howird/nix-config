{inputs, ...}: {
  flake-file.inputs = {
    pi = {
      url = "github:lukasl-dev/pi.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.pi.homeManager = {pkgs, ...}: let
    inherit (pkgs.stdenv.hostPlatform) system;
  in {
    imports = [
      ./_pi/binds.nix
      ./_pi/plugins.nix
      ./_pi/settings.nix
      ./_pi/skills.nix
    ];

    _module.args.mattpocockSkillsSrc = inputs.mattpocock-skills;

    programs.pi-coding-agent = {
      enable = true;
      package = inputs.pi.packages.${system}.default;
    };
  };
}
