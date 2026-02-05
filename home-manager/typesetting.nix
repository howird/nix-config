{pkgs, ...}: {
  home.packages = with pkgs; [
    obsidian
    presenterm
    percollate

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
