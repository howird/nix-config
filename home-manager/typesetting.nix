{pkgs, ...}: {
  home.packages = with pkgs; [
    obsidian
    presenterm

    texliveFull
    zotero
    pandoc
    pdftk

    typst
    typstyle
    tinymist
    hayagriva
  ];
}
