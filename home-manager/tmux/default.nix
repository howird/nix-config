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
      set -g @plugin 'o0th/tmux-nova'

      set -g @nova-nerdfonts true
      set -g @nova-nerdfonts-left 
      set -g @nova-nerdfonts-right 

      set -g @nova-segment-mode "#{?client_prefix,WAIT,TMUX}"
      set -g @nova-segment-whoami "#(whoami)@#h %I:%M:%S %p %a %b %d"
      set -g @nova-pane "#I#{?pane_in_mode,  #{pane_mode},}  #W"

      set -g @nova-rows 0
      set -g @nova-segments-0-left "mode"
      set -g @nova-segments-0-right "whoami"

      # conflicts with neovim harpoon
      unbind-key -T root C-h
      unbind-key -T root C-j
      unbind-key -T root C-k
      unbind-key -T root C-l
    '';

    plugins = with pkgs.tmuxPlugins; [
      tmux-nova
      sensible
      yank
      vim-tmux-navigator
    ];
  };

  home.packages = with pkgs; [
    (writeShellScriptBin "tat" (builtins.readFile ./tat))
    (writeShellScriptBin "tsel" ''tmux list-sessions | sed -E 's/:.*$//' | fzf --reverse'')
  ];
}
