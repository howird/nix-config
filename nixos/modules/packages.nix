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
    neofetch
    htop
    lsof
    pciutils
    cachix
    wget
    zoxide
    eza
    ripgrep
    bat
    fd
    fzf
    python3
    ffmpeg-headless
    yt-dlp
    gitui
    ncspot
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
    zsh.enable = true;
    fish.enable = true;
    tmux.enable = true;
  };
}
