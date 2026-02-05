{
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf config.myShell.zsh {
  programs.zsh = let
    zesh = "${pkgs.zesh}/bin/zesh";
    fzf = "${pkgs.fzf}/bin/fzf";
  in {
    enable = true;
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
        if [[ -z "$TMUX" && -z "$ZELLIJ" && $TERM_PROGRAM != "vscode" && $TERM_PROGRAM != "zed" ]]; then
          ${zesh} cn $(${zesh} l | ${fzf})
        fi
      ''
      else ''
        source ${./scripts/auto_tmux.sh}

        # ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(
        #   zhm_history_prev
        #   zhm_history_next
        #   zhm_prompt_accept
        #   zhm_accept
        #   zhm_accept_or_insert_newline
        # )
        # ZSH_AUTOSUGGEST_ACCEPT_WIDGETS+=(
        #   zhm_move_right
        #   zhm_clear_selection_move_right
        # )
        # ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=(
        #   zhm_move_next_word_start
        #   zhm_move_next_word_end
        # )

        # zhm_wrap_widget fzf-completion zhm_fzf_completion
        # bindkey '^I' zhm_fzf_completion
      ''
    );

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
      # {
      #   name = "zsh-helix-mode";
      #   src = pkgs.zsh-helix-mode;
      #   file = "share/zsh-helix-mode/zsh-helix-mode.plugin.zsh";
      # }
      {
        name = "zsh-autopair";
        src = pkgs.zsh-autopair;
        file = "share/zsh/zsh-autopair/autopair.zsh";
      }
    ];
  };
}
