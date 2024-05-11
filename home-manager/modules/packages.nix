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

    discord
    teams-for-linux

    stremio
    spotify
  ];
}
