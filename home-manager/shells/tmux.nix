{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    customPaneNavigationAndResize = true;
    # mouse = true;
    shortcut = "Space";
    extraConfig = ''
      set -g set-clipboard on
      set -g status-right '<#H> %I:%M %p %Y-%m-%d'

      unbind t
      bind t send-keys "tat" "C-m"
      unbind r
      bind r split-window -v "tmux list-sessions | sed -E 's/:.*$//' | grep -v \"^$(tmux display-message -p '#S')\$\" | fzf --reverse | xargs tmux switch-client -t"

      set-window-option -g mode-keys vi
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
    '';
    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      vim-tmux-navigator
    ];
  };

  home.packages = with pkgs; [
    (writeShellScriptBin "tat" (builtins.readFile ./scripts/tat))
  ];
}
