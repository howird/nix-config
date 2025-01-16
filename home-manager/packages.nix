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

    reaper
    audacity

    rnote
    krita
    obs-studio
    kdenlive

    obsidian
    texliveFull
    zotero
    libreoffice-qt
    scrcpy

    discord
    teams-for-linux
    slack
    zoom-us

    # intentional watching, not streaming!
    qbittorrent
    spotify

    # inputs.pix2tex.packages.${system}.default
    aider-chat
    fabric-ai
  ];
}
