{
  lib,
  config,
  ...
}: {
  imports = [
    ./apps
    ./browsers
    ./editors
    ./life
    ./shells

    ./ghostty.nix
    ./git.nix
    ./htop.nix
    ./programming.nix
    ./rclone.nix
    ./sioyek.nix
    ./thunar.nix
    ./typesetting.nix
    ./voxtype.nix
  ];

  config = {
    myShell.zsh = true;

    # programs.vscode.enable = true;
    programs.helix.enable = true;

    myBrowser.zen = true;

    programs.home-manager.enable = true;
    home = {
      username = lib.mkDefault "howird";
      homeDirectory = "/home/${config.home.username}";
      sessionPath = ["$HOME/.local/bin"];
    };

    # Nicely reload system units when changing configs
    systemd.user.startServices = "sd-switch";

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    home.stateVersion = "23.11";
  };

  options = {
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
