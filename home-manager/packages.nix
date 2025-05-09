{pkgs, ...}: {
  home.packages = with pkgs; [
    openconnect_openssl
    networkmanager

    reaper
    audacity

    krita
    obs-studio

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
    ncspot

    # inputs.pix2tex.packages.${system}.default
    aider-chat
    fabric-ai
    code-cursor
  ];
}
