{
  den.aspects.doctools.homeManager = {pkgs, ...}: {
    home.packages = with pkgs; [
      zotero
      pandoc
      pdftk
    ];
  };
}
