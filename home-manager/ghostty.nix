{...}: {
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    installVimSyntax = true;
    settings = {
      background-opacity = 0.7;
      background-blur = true;
      confirm-close-surface = false;
    };
  };
}
