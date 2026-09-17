{den, ...}: {
  den.aspects.howard.includes = [
    den.aspects.gnome
    den.aspects.stylix

    den.aspects.bundles.shell
    den.aspects.bundles.editors
    den.aspects.bundles.agents
    den.aspects.bundles.devtools
    den.aspects.bundles.docs
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

    # Standalone home-manager: no host to name the flake output after.
    myShell.hmFlakeArgs = "#${config.home.username}@vip";

    stylix.autoEnable = false;
    stylix.targets.zellij.enable = true;
    stylix.targets.zed.enable = true;
    stylix.targets.gnome.enable = true;
    stylix.targets.gtk.enable = true;
  };
}
