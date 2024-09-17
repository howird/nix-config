{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # List packages installed in system profile. To search, run: `nix search wget`
  environment.systemPackages = with pkgs; [
    home-manager

    # utilities
    busybox
    fastfetch
    htop
    lsof
    pciutils
    cachix
    wget
    fzf
    python3
    ffmpeg-headless
    yt-dlp
    sshfs
    unrar
    pixi

    # apps
    firefox
    chromium
    vlc
    amberol
    gimp
    xournalpp
  ];

  programs = {
    git.enable = true;
    tmux.enable = true;
    zsh.enable = true;
    nm-applet.enable = true;
  };
}
