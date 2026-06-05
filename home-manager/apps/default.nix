{pkgs, ...}: {
  imports = [
    ./default-apps.nix
  ];

  home.packages = with pkgs; [
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

    eyedropper
    gimp
    darktable
    krita

    readest
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
