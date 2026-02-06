{
  lib,
  pkgs,
  ...
}: {
  programs.zsh = {
    initContent = lib.mkAfter ''
      ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(
        zhm_history_prev
        zhm_history_next
        zhm_prompt_accept
        zhm_accept
        zhm_accept_or_insert_newline
      )
      ZSH_AUTOSUGGEST_ACCEPT_WIDGETS+=(
        zhm_move_right
        zhm_clear_selection_move_right
      )
      ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=(
        zhm_move_next_word_start
        zhm_move_next_word_end
      )

      # zhm_wrap_widget fzf-completion zhm_fzf_completion
      # bindkey '^I' zhm_fzf_completion
    '';

    plugins = [
      {
        name = "zsh-helix-mode";
        src = pkgs.zsh-helix-mode;
        file = "share/zsh-helix-mode/zsh-helix-mode.plugin.zsh";
      }
    ];
  };
}
