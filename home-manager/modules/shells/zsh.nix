{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf config.myShell.zsh {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
    shellAliases = config.myShell.aliases;
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
      {
        name = "zsh-vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.zsh";
      }
      {
        name = "zsh-autopair";
        src = pkgs.zsh-autopair;
        file = "share/zsh/zsh-autopair/autopair.zsh";
      }
      # {
      #   name = "zsh-system-clipboard";
      #   src = pkgs.zsh-system-clipboard;
      #   file = "share/zsh/zsh-system-clipboard/zsh-system-clipboard.zsh";
      # }
    ];
  };
}
