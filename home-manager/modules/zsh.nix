{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    shellAliases = {
      nixwird = "sudo nixos-rebuild switch --flake /home/howird/.config/nix";
      nixwird-hm = "home-manager switch --flake /home/howird/.config/nix";

      ll = "ls -l";
      vim = "lvim";

      tl = "tmux list-sessions";
      ts = "tmux new-session -s";
      ta = "tmux attach-session -t";
      tks = "tmux kill-session -t";

      campus-ssh-toggle = "bash ${ ../misc/campus-ssh-toggle.sh }";
    };
    history = {
      size = 10000;
      path = "$HOME/.config/zsh/history";
    };
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ../misc;
        file = ".p10k.zsh";
      }
    ];
  };
}
