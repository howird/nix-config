{
  den.aspects.latex.homeManager = {pkgs, ...}: {
    home.packages = with pkgs; [
      texliveFull
      tectonic
      texlab
    ];
  };
}
