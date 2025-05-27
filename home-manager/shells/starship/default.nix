{config, ...}: {
  imports = [
    ./starship.nix
  ];

  programs.starship = {
    enable = true;
    enableZshIntegration = config.myShell.zsh;
    enableFishIntegration = config.myShell.fish;
  };
}
