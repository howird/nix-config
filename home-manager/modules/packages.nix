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

    kicad
    krita
    blender-hip
    obs-studio
    kdenlive

    obsidian
    texliveFull
    zotero

    discord
    teams-for-linux
    zoom-us

    qbittorrent
    spotify
  ];
}
