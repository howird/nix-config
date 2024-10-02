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

    discord
    teams-for-linux
    zoom-us

    qbittorrent
    spotify
  ];
}
