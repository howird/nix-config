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

    obsidian
    texlive.combined.scheme-full
    zotero

    discord
    teams-for-linux

    stremio
    spotify
  ];

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };
}
