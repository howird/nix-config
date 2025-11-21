{pkgs, ...}: {
  imports = [
    ./helix.nix
    ./languages.nix
    ./binds.nix
  ];

  programs.helix.defaultEditor = true;
  home.packages = with pkgs; [
    yazi
  ];
}
