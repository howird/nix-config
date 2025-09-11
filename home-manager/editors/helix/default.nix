{config, ...}: {
  imports = [
    ./languages.nix
  ];
  programs.helix = {
    enable = config.myEditor.helix;
  };
}
