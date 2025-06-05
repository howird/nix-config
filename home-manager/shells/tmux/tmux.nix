{config, ...}: {
  programs.tmux = {
    shortcut = "Space";
    extraConfig =
      ''
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
        unbind-key -T root C-\;
        unbind-key -T root C-J
        unbind-key -T root C-K

        set -g @catppuccin_flavor "mocha"
        set -g @catppuccin_window_status_style "rounded"

        set -g status-right-length 100
        set -g status-left-length 100
        set -g status-left ""
        set -g status-right "#{E:@catppuccin_status_application}"
        set -ag status-right "#{E:@catppuccin_status_session}"
        set -ag status-right "#{E:@catppuccin_status_uptime}"
      ''
      + (
        if builtins.hasAttr "stylix" config.lib
        then
          (let
            colors = config.lib.stylix.colors.withHashtag;
            green = colors.base0B;
            surface0 = colors.base02;
            surface1 = colors.base03;
            surface2 = colors.base04;
            mauve = colors.base0E;
          in ''

            set -g @catppuccin_pane_color "${green}"
            set -g @catppuccin_pane_background_color "${surface0}"
            set -g @catppuccin_window_text_color "${surface0}"
            set -g @catppuccin_window_number_color "${surface2}"
            set -g @catppuccin_window_current_text_color "${surface1}"
            set -g @catppuccin_window_current_number_color "${mauve}"
            set -g @catppuccin_status_module_bg_color "${surface0}"
          '')
        else ""
      );
  };
}
