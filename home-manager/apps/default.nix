{pkgs, ...}: {
  imports = [
    ./default-apps.nix
  ];

  home.packages = with pkgs; [
    openconnect_openssl
    networkmanager

    # reaper
    audacity
    obs-studio
    video-trimmer
    eyedropper
    krita

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
  ];
}
