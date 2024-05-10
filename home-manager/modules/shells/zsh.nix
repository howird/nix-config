{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.zsh = {
    autosuggestion.enable = true;
    enableCompletion = true;
    shellAliases = config.myShellAliases;
    history = {
      size = 10000;
      path = "$HOME/.config/zsh/history";
    };
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ../../misc;
        file = ".p10k.zsh";
      }
    ];
  };
}
