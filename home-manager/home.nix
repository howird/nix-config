{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./modules/kde.nix
    ./modules/git.nix
    ./modules/nvim.nix
    ./modules/vscode.nix
    ./modules/alacritty.nix
    ./modules/zsh.nix
    ./modules/fish.nix
    ./modules/tmux.nix
    ./modules/chromium.nix
  ];

  programs.home-manager.enable = true;

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
    ];
    config = { allowUnfree = true; };
  };

  home = {
    username = "howird";
    homeDirectory = "/home/howird";
    sessionPath = [
      "$HOME/.local/bin"
    ];
    packages = with pkgs; [
      openconnect
      gtkwave

      obsidian
      texlive.combined.scheme-full

      discord
      teams-for-linux

      stremio
      spotify
    ];
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
