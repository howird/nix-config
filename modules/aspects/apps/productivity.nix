{
  den.aspects.productivity.homeManager = {pkgs, ...}: {
    home.packages = import ./_available.nix pkgs (with pkgs; [
      obsidian
      typora
      drawio
      linear
    ]);
  };
}
