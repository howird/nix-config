{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    openconnect_openssl
    networkmanager
    kdePackages.plasma-nm

    krita
    blender-hip
    obs-studio
    kdenlive

    code-cursor
    obsidian
    texliveFull
    zotero
    libreoffice-qt

    discord
    teams-for-linux
    zoom-us

    qbittorrent
    spotify
    inputs.pix2tex.packages.x86_64-linux.default
  ];
}
