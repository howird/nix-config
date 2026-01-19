{
  imports = [
    ./languages

    ./helix.nix
    ./binds.nix
  ];

  programs.helix.defaultEditor = true;
  programs.yazi.enable = true;
}
