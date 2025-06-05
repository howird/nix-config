{
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

    initContent = lib.mkBefore (''
        eval "$(${pkgs.zoxide}/bin/zoxide init zsh)"
      ''
      + (
        if config.programs.zellij.enable
        then ''
          if [[ -z "$TMUX" && -z "$ZELLIJ" && $TERM_PROGRAM != "vscode" && $TERM_PROGRAM != "zed" ]]; then
            zls
          fi
        ''
        else ''
          source ${./scripts/auto_tmux.sh}
        ''
      ));

    history = {
      size = 10000;
      path = "$HOME/.config/zsh/history";
    };

    plugins = [
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
    ];
  };
}
