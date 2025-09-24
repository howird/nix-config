{
  programs.ghostty = {
    enableZshIntegration = true;
    installVimSyntax = true;
    settings = {
      window-decoration = "none";
      # background-opacity = 0.8;
      background-blur = true;
      confirm-close-surface = false;
      keybind = [
        "ctrl+shift+j=unbind"
      ];
    };
  };
}
