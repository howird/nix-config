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
    shortcut = "a";
    extraConfig = lib.strings.concatStringsSep "\n" [
      "unbind t"
      ''bind t send-keys "tat" "C-m"''
      "unbind r"
      ''bind r split-window -v "tmux list-sessions | sed -E 's/:.*$//' | grep -v \"^$(tmux display-message -p '#S')\$\" | fzf --reverse | xargs tmux switch-client -t"''
    ];
  };
}
