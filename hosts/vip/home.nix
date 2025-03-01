{
  config,
  ...
}: {
  imports = [
    ../../home-manager
  ];

  config = let
    initExtra = ''
      HOME_PROFILE="/home/${config.myUsername}/.nix-profile/etc/profile.d"
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
    myUsername = "howard";
    myEmail = "howard.nguyen-huu@uwaterloo.ca";

    programs.zsh.initExtraFirst = initExtra;
    programs.bash.initExtra = initExtra;
    myShell.hmFlakeArgs = "#howard@vip";
  };
}
