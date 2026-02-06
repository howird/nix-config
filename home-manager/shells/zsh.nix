{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./zsh_hx.nix
  ];

  programs.zsh = {
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
    shellAliases = config.myShell.aliases;

    initContent = lib.mkBefore (
      if config.programs.zellij.enable
      then ''
        precmd() {
          echo -n -e "\033]0;TEXT\007"
        }
        if [[ -z "$TMUX" && -z "$ZELLIJ" && -z $FILEBROWSER && $TERM_PROGRAM != "vscode" && $TERM_PROGRAM != "zed" ]]; then
          ${pkgs.zesh}/bin/zesh cn $(${pkgs.zesh}/bin/zesh l | ${pkgs.fzf}/bin/fzf)
        fi
      ''
      else ''
        source ${./scripts/auto_tmux.sh}
      ''
    );

    history = {
      size = 10000;
      path = "$HOME/.config/zsh/history";
    };

    plugins = [
      # {
      #   name = "zsh-vi-mode";
      #   src = pkgs.zsh-vi-mode;
      #   file = "share/zsh-vi-mode/zsh-vi-mode.zsh";
      # }
      {
        name = "zsh-autopair";
        src = pkgs.zsh-autopair;
        file = "share/zsh/zsh-autopair/autopair.zsh";
      }
    ];
  };
}
