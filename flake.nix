# DO-NOT-EDIT. This file was auto-generated using github:denful/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{
  description = "Howard's dendritic NixOS + home-manager configuration, using Den";

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);

  inputs = {
    claude-code = {
      url = "github:ryoppippi/nix-claude-code";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    claude-desktop = {
      url = "github:heytcass/claude-desktop-linux-flake";
      inputs = {
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
      };
    };
    clipboard-yazi = {
      url = "github:XYenon/clipboard.yazi";
      flake = false;
    };
    crane.url = "github:ipetkov/crane";
    darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    den.url = "github:denful/den";
    flake-file.url = "github:denful/flake-file";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    granola = {
      url = "github:howird/granola-flake";
      inputs = {
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
      };
    };
    hardware.url = "github:nixos/nixos-hardware";
    helix-plugins = {
      url = "git+https://codeberg.org/maxschipper/helix-plugins-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    import-tree.url = "github:denful/import-tree";
    math-hx = {
      url = "github:howird/math.hx";
      inputs = {
        helix-plugins.follows = "helix-plugins";
        nixpkgs.follows = "nixpkgs";
      };
    };
    mattpocock-skills = {
      url = "github:mattpocock/skills";
      flake = false;
    };
    niri = {
      url = "github:epireyn/niri-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpkgs-stable.follows = "nixpkgs-stable";
      };
    };
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    nixgl = {
      url = "github:nix-community/nixGL";
      inputs = {
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
      };
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-26.05";
    noctalia.url = "github:noctalia-dev/noctalia";
    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    paseo = {
      url = "github:getpaseo/paseo";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pi = {
      url = "github:lukasl-dev/pi.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    voxtype = {
      url = "github:peteonrails/voxtype";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:/0xc000022070/zen-browser-flake";
      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
    };
    zesh = {
      url = "github:roberte777/zesh";
      inputs = {
        crane.follows = "crane";
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
      };
    };
  };
}
