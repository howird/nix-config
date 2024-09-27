{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../home.nix
  ];

  config = let
    initExtra = ''
      source /home/${config.myUsername}/.nix-profile/etc/profile.d/nix.sh
      source /home/${config.myUsername}/.nix-profile/etc/profile.d/hm-session-vars.sh
    '';
  in {
    myUsername = "howard";
    myEmail = "howard.nguyen-huu@uwaterloo.ca";

    programs.zsh.initExtraFirst = initExtra;
    programs.bash.initExtra = initExtra;
    myShell.hmFlakeArgs = "#howard@vip";
  };
}
