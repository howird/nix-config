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
    (obsidian.override {
      commandLineArgs = [
        "--enable-features=UseOzonePlatform"
        "--ozone-platform=wayland"
      ];
    })
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
