{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    kicad
    blender-hip
    obs-studio
    kdenlive

    obsidian
    texlive.combined.scheme-full
    zotero

    discord
    teams-for-linux

    qbittorrent
    spotify
  ];

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };
}
