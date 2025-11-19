{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./helix.nix
    ./languages.nix
    ./binds.nix
  ];
  programs.helix = {
    enable = config.myEditor.helix;
    defaultEditor = true;
  };

  home.packages = with pkgs; [
    yazi
  ];
}
