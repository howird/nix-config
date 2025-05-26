{pkgs, ...}: {
  programs.tmux = {
    enable = true;

    keyMode = "vi";
    customPaneNavigationAndResize = true;

    shortcut = "Space";
    extraConfig = ''
      set-option -g status-position top
      set -g set-clipboard on

      unbind t
      bind t send-keys "tat" "C-m"
      unbind r
      bind r split-window -v "tsel | xargs tmux switch-client -t"

      set-window-option -g mode-keys vi
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      # conflicts with neovim harpoon
      unbind-key -T root C-h
      unbind-key -T root C-j
      unbind-key -T root C-k
      unbind-key -T root C-l

      set -g @catppuccin_flavor "mocha"
      set -g @catppuccin_window_status_style "rounded"

      set -g status-right-length 100
      set -g status-left-length 100
      set -g status-left ""
      set -g status-right "#{E:@catppuccin_status_application}"
      set -ag status-right "#{E:@catppuccin_status_session}"
      set -ag status-right "#{E:@catppuccin_status_uptime}"
    '';

    plugins = with pkgs.tmuxPlugins; [
      catppuccin
      sensible
      vim-tmux-navigator
      yank
    ];
  };

  home.packages = with pkgs; [
    (writeShellScriptBin "tat" (builtins.readFile ./tat))
    (writeShellScriptBin "tsel" ''tmux list-sessions | sed -E 's/:.*$//' | fzf --reverse'')
  ];
}
