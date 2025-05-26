{
  config,
  lib,
  ...
}: {
  programs.starship = {
    enable = true;
    enableZshIntegration = config.myShell.zsh;
    enableFishIntegration = config.myShell.fish;
  };
  xdg.configFile."starship.toml".source = lib.mkForce ./starship.toml;
}
