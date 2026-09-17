{inputs, ...}: {
  flake-file.inputs.zesh = {
    url = "github:roberte777/zesh";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.crane.follows = "crane";
    inputs.flake-utils.follows = "flake-utils";
  };

  den.aspects.zellij.homeManager = {pkgs, ...}: let
    inherit (pkgs.stdenv.hostPlatform) system;
  in {
    imports = [
      ./_zellij/zellij.nix
      ./_zellij/default-layout.nix
      ./_zellij/tab-bar.nix
    ];

    programs.zellij.enable = true;
    programs.zellij.tab-bar.name = "zjstatus";

    home.packages = [
      inputs.zesh.packages.${system}.default
    ];

    myShell.aliases = {
      zh = "zesh cn .";
      zls = ''selected=$(zesh list | fzf | sed "s|^~|$HOME|"); [[ -n $selected ]] && zesh connect "$selected"'';
    };
  };
}
