{pkgs, ...}: {
  # List packages installed in system profile. To search, run: `nix search wget`
  environment.systemPackages = with pkgs; [
    home-manager

    # utilities
    busybox
    fastfetch
    lsof
    pciutils
    cachix
    wget
    python3
    ffmpeg-headless
    yt-dlp
    unrar
    imagemagick
    xorg.xhost

    # apps
    firefox
    vlc
    libreoffice
    gnome-disk-utility
    gnome-text-editor
    kdePackages.okular # pdf-markup
    papers # pdf
    foliate # ebooks
    rhythmbox # music
    loupe # image viewer
  ];

  programs = {
    git.enable = true;
    tmux.enable = true;
    zsh.enable = true;
    fish.enable = true;
    nm-applet.enable = true;
  };
}
