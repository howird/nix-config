{den, ...}: {
  # Reading and writing documents. Deliberately separate from `devtools` —
  # a headless machine wants the tools and none of texlive.
  den.aspects.docs.includes = [
    den.aspects.sioyek
    den.aspects.latex
    den.aspects.typst
    den.aspects.doctools
  ];
}
