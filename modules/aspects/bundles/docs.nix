{den, ...}: {
  # Reading and writing documents. Deliberately separate from `devtools` —
  # a headless machine wants the tools and none of texlive.
  den.aspects.bundles.docs.includes = [
    den.aspects.sioyek
    den.aspects.typesetting
  ];
}
