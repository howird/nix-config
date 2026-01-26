{pkgs, ...}: {
  imports = [
    ./default-apps.nix
  ];

  home.packages = with pkgs; [
    openconnect_openssl
    networkmanager

    audacity
    obs-studio
    video-trimmer
    eyedropper
    krita
    gimp
    rnote
    anki
    sioyek

    vesktop
    slack
    zoom-us

    # intentional watching, not streaming!
    qbittorrent
    spotify
    ncspot
    fretboard
    gnome-decoder
    warp
    blanket
    apostrophe
  ];
}
