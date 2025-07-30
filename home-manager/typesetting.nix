{pkgs, ...}: {
  home.packages = with pkgs; [
    obsidian
    presenterm

    texliveFull
    zotero
    pandoc

    typst
    typstyle
    tinymist
    hayagriva
  ];
}
