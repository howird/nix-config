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
  };
  programs.eza = {
    enable = true;
    enableZshIntegration = config.myShell.zsh;
    enableFishIntegration = config.myShell.fish;
  };
  programs.fzf = {
    enable = true;
    enableZshIntegration = config.myShell.zsh;
    enableFishIntegration = config.myShell.fish;
  };
  programs.zoxide = {
    enable = true;
    enableZshIntegration = config.myShell.zsh;
    enableFishIntegration = config.myShell.fish;
  };
}
