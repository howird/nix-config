{
  den.aspects.typst.homeManager = {pkgs, ...}: {
    home.packages = with pkgs; [
      typst
      typstyle
      tinymist
      hayagriva
    ];
  };
}
