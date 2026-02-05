{pkgs, ...}: {
  imports = [
    ./default-apps.nix
  ];

  home.packages = with pkgs; [
    openconnect_openssl
    networkmanager
    aria2

    audacity
    obs-studio
    video-trimmer
    eyedropper
    krita
    gimp
    darktable

    rnote
    anki

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
