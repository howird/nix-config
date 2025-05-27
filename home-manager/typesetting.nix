{pkgs, ...}: {
  home.packages = with pkgs; [
    obsidian
    presenterm

    texliveFull
    zotero

    typst
    typstyle
    typst-live
  ];
}
