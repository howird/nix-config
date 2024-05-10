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
    yt-dlp
    gitui
    ncspot

    # apps
    firefox
    vlc
    amberol
    gimp
    xournalpp

    # programming
    python3
    ffmpeg-headless
    nodejs
    cargo
    rustc
    gcc
    gnumake
  ];

  programs = {
    git.enable = true;
    zsh.enable = true;
    fish.enable = true;
    tmux.enable = true;
  };
}
