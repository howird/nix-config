{den, ...}: {
  # Writing documents from the command line: tex, typst and conversion
  # tools. All CLI, so it goes everywhere; the readers (sioyek, zotero) are
  # graphical and live in apps' `reading`.
  den.aspects.typesetting.includes = [
    den.aspects.latex
    den.aspects.typst
  ];

  den.aspects.typesetting.homeManager = {pkgs, ...}: {
    home.packages = with pkgs; [
      pandoc
      pdftk
    ];
  };
}
