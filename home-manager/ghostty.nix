{...}: {
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    installVimSyntax = true;
    settings = {
      background-opacity = 0.8;
      background-blur = true;
      confirm-close-surface = false;
      keybind = [
        "ctrl+shift+j=unbind"
      ];
    };
  };
}
