{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    openconnect
    gtkwave
    krita

    obsidian
    texlive.combined.scheme-full
    zotero

    discord
    teams-for-linux
    element-desktop

    stremio
    spotify
  ];

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };
}
