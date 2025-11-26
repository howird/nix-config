{
  imports = [
    ./helix.nix
    ./languages.nix
    ./binds.nix
  ];

  programs.helix.defaultEditor = true;
  programs.yazi.enable = true;
}
