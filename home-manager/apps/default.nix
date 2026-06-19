{pkgs, ...}: {
  imports = [
    ./default-apps.nix
  ];

  home.packages = with pkgs; [
    apostrophe
    readest
    obsidian
    presenterm
    percollate
    wordbook
    wike

    openconnect_openssl
    networkmanager
    aria2
    dex

    audacity
    obs-studio
    kdePackages.kdenlive

    f3d
    drawio
    eyedropper
    gimp
    darktable
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
