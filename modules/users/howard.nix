{den, ...}: {
  den.aspects.howard.includes = [
    den.aspects.gnome

    # shared with howird
    den.aspects.editors-helix
    den.aspects.editors-vscode
    den.aspects.editors-zed
    den.aspects.editors-agents
    den.aspects.shells-zsh
    den.aspects.shells-fish
    den.aspects.shells-starship
    den.aspects.shells-zellij
    den.aspects.shell-aliases
    den.aspects.ghostty
    den.aspects.git
    den.aspects.htop
    den.aspects.programming
    den.aspects.sioyek
    den.aspects.typesetting
    den.aspects.yazi
    den.aspects.stylix
  ];

  den.aspects.howard.homeManager = {
    config,
    lib,
    ...
  }: let
    initExtra = ''
      HOME_PROFILE="/home/${config.home.username}/.nix-profile/etc/profile.d"
      ROOT_NIX_SH="/etc/profile.d/nix.sh"
      HOME_NIX_SH="$HOME_PROFILE/nix.sh"

      if [ -f $ROOT_NIX_SH ]; then
        source $ROOT_NIX_SH
      elif [ -f $HOME_NIX_SH ]; then
        source $HOME_NIX_SH
      else
        echo "ERROR: nix.sh not sourced!"
      fi

      source $HOME_PROFILE/hm-session-vars.sh
    '';
  in {
    home.username = "howard";

    programs.zsh.initContent = lib.mkBefore initExtra;
    programs.bash.initExtra = initExtra;
    myShell.hmFlakeArgs = "#${config.home.username}@vip";

    myShell.aliases.nixwird = "home-manager switch --flake /home/${config.home.username}/nix/config${config.myShell.hmFlakeArgs}";
    stylix.autoEnable = false;
    stylix.targets.zellij.enable = true;
    stylix.targets.zed.enable = true;
    stylix.targets.gnome.enable = true;
    stylix.targets.gtk.enable = true;

    programs.nh = {
      enable = true;
      flake = "/home/${config.home.username}/nix/config";
    };
  };
}
