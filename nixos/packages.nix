{
  pkgs,
  ...
}: {
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
    sshfs
    unrar
    imagemagick
    xorg.xhost

    # apps
    firefox
    chromium
    vlc
    libreoffice
    evince # pdf
    xournalpp # pdf+markup
    foliate # ebooks
    rhythmbox # music
  ];

  programs = {
    git.enable = true;
    tmux.enable = true;
    zsh.enable = true;
    nm-applet.enable = true;
  };
}
