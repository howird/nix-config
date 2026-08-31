{...}: {
  flake-file.inputs.zesh = {
    url = "github:roberte777/zesh";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.crane.follows = "crane";
    inputs.flake-utils.follows = "flake-utils";
  };

  den.aspects.shells-zellij.homeManager = {pkgs, ...}: {
    imports = [
      ./_shells-zellij/zellij.nix
      ./_shells-zellij/default-layout.nix
      ./_shells-zellij/tab-bar.nix
    ];

    programs.zellij.enable = true;
    programs.zellij.tab-bar.name = "zjstatus";

    home.packages = with pkgs; [
      zesh
    ];

    myShell.aliases = {
      zh = "zesh cn .";
      zls = ''selected=$(zesh list | fzf | sed "s|^~|$HOME|"); [[ -n $selected ]] && zesh connect "$selected"'';
    };
  };
}
