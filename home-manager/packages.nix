{pkgs, ...}: {
  home.packages = with pkgs; [
    openconnect_openssl
    networkmanager

    yazi
    timg

    reaper
    audacity

    rnote
    krita
    obs-studio
    kdePackages.kdenlive

    ticktick
    obsidian
    texliveFull
    zotero
    zathura # pdf keyboard-based

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
