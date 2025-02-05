{
  lib,
  config,
  ...
}: {
  imports = [
    ./shells
    ./editors
    ./browsers
    ./tmux

    ./packages.nix
    ./programming.nix
    ./git.nix
    ./htop.nix
  ];

  config = {
    myShell.zsh = true;

    myEditor.vscode = true;
    myEditor.nvim = true;
    myEditor.helix = true;

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
