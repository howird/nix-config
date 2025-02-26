{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    scrcpy
    openconnect_openssl
    networkmanager

    reaper
    audacity

    rnote
    krita
    obs-studio
    kdenlive

    ticktick
    gnome-text-editor
    obsidian
    texliveFull
    zotero
    zathura # pdf keyboard-based
    parsec-bin

    vesktop
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
