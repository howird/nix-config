{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    ./modules/hyprland/hyprland.nix
    ./modules/gnome.nix
    ./modules/git.nix
    ./modules/nvim.nix
    ./modules/vscode.nix
    ./modules/alacritty.nix
    ./modules/zsh.nix
    ./modules/fish.nix
    ./modules/tmux.nix
  ];

  programs.home-manager.enable = true;

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config = { allowUnfree = true; };
  };

  home = {
    username = "howird";
    homeDirectory = "/home/howird";
    sessionPath = [
      "$HOME/.local/bin"
    ];
    packages = ( with pkgs; [
      texlive.combined.scheme-full
      # stremio
      spotify
    ]) ++ ( with pkgs.unstable; [
      obsidian
      discord
    ]);
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
