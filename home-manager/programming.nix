{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    dust
    dua

    ast-grep
    serpl
    just

    devenv
    nixd
    textpieces

    bun
    aider-chat
    fabric-ai
    cursor-cli
    goose-cli
  ];

  services.lorri.enable = true;
  programs.ripgrep.enable = true;
  programs.uv.enable = true;
  programs.fd.enable = true;
  programs.bat.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = config.programs.zsh.enable;
    enableFishIntegration = config.programs.fish.enable;
  };
  programs.eza = {
    enable = true;
    enableZshIntegration = config.programs.zsh.enable;
    enableFishIntegration = config.programs.fish.enable;
  };
  programs.fzf = {
    enable = true;
    enableZshIntegration = config.programs.zsh.enable;
    enableFishIntegration = config.programs.fish.enable;
  };
  programs.zoxide = {
    enable = true;
    enableZshIntegration = config.programs.zsh.enable;
    enableFishIntegration = config.programs.fish.enable;
  };
}
