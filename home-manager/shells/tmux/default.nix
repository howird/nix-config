{pkgs, ...}: {
  programs.tmux = {
    enable = true;

    keyMode = "vi";
    customPaneNavigationAndResize = true;
    plugins = with pkgs.tmuxPlugins; [
      catppuccin
      sensible
      vim-tmux-navigator
      yank
    ];
  };

  home.packages = with pkgs; [
    (writeShellScriptBin "tat" (builtins.readFile ../scripts/tat))
    (writeShellScriptBin "tsel" ''tmux list-sessions | sed -E 's/:.*$//' | fzf --reverse'')
  ];
}
