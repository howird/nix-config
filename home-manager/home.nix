{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./modules/packages.nix

    ./modules/desktops/default.nix
    ./modules/editors/default.nix
    ./modules/shells/default.nix
    ./modules/browsers/default.nix

    ./modules/git.nix
    ./modules/alacritty.nix
    ./modules/tmux.nix
  ];

  config = {
    myDesktop.kde = true;
    myWallpaper = ./misc/wallpapers/fall-forest.jpg;

    myEditor.vscode = true;
    myEditor.nvim = true;

    myBrowser.vivaldi = true;
    myBrowser.floorp = true;

    programs.home-manager.enable = true;

    nixpkgs = {
      overlays = [
        outputs.overlays.additions
        outputs.overlays.modifications
      ];
      config = {allowUnfree = true;};
    };

    home = {
      username = "howird";
      homeDirectory = "/home/howird";
      sessionPath = [
        "$HOME/.local/bin"
      ];
    };

    # Nicely reload system units when changing configs
    systemd.user.startServices = "sd-switch";

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    home.stateVersion = "23.11";
  };
}
