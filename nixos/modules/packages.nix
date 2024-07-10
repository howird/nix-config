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
  };
}
