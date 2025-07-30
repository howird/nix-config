{pkgs, ...}: {
  home.packages = with pkgs; [
    openconnect_openssl
    networkmanager

    reaper
    # audacity
    obs-studio
    video-trimmer
    eyedropper
    krita

    vesktop
    slack
    zoom-us
    warp

    # intentional watching, not streaming!
    qbittorrent
    spotify
    ncspot
    fretboard
  ];
}
