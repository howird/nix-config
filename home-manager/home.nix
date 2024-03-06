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
    # ./nvim.nix
    ./hyprland/hyprland.nix
    ./gnome.nix
    ./git.nix
    ./alacritty.nix
    ./zsh/zsh.nix
    ./fish.nix
    ./vscode.nix
  ];

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
      texliveMedium
      stremio
      spotify
    ]) ++ ( with pkgs.unstable; [
      lunarvim
      obsidian
      discord
    ]);
  };

  programs.home-manager.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
