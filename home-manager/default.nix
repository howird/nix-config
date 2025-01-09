{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./shells
    ./editors

    ./programming.nix
    ./git.nix
    ./tmux.nix
    ./htop.nix
    ./gpg.nix
    ./mpv.nix
    ./mime-apps.nix
  ];

  config = {
    myShell.zsh = true;
    myEditor.nvim = true;

    programs.home-manager.enable = true;
    home = {
      username = config.myUsername;
      homeDirectory = "/home/${config.myUsername}";
      sessionPath = ["$HOME/.local/bin"];
    };

    # Nicely reload system units when changing configs
    systemd.user.startServices = "sd-switch";

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    home.stateVersion = "23.11";
  };

  options = {
    myUsername = lib.mkOption {
      type = lib.types.str;
      default = "howird";
      description = "your username";
    };

    myName = lib.mkOption {
      type = lib.types.str;
      default = "Howard Nguyen-Huu";
      description = "your name";
    };

    myEmail = lib.mkOption {
      type = lib.types.str;
      default = "howardnguyenhuu@gmail.com";
      description = "your email";
    };
  };
}
