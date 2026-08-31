{...}: {
  den.aspects.typesetting.homeManager = {pkgs, ...}: {
    home.packages = with pkgs; [
      texliveFull
      zotero
      pandoc
      pdftk

      typst
      typstyle
      tinymist
      hayagriva
    ];
  };
}
