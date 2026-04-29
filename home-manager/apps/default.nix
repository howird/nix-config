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
    kdePackages.kdenlive

    eyedropper
    gimp
    darktable
    graphite

    rnote
    anki
    appflowy

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
