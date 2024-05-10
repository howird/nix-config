{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./fish.nix
    ./zsh.nix
  ];

  options = {
    myShellAliases = lib.mkOption {
      type = lib.types.attrs;
      default = {};
    };
  };

  config = {
    programs.fish.enable = true;
    programs.zsh.enable = true;

    myShellAliases = {
      nixwird = "sudo nixos-rebuild switch --flake /home/howird/.config/nix";
      nixwird-hm = "home-manager switch --flake /home/howird/.config/nix";

      tl = "tmux list-sessions";
      ts = "tmux new-session -s";
      ta = "tmux attach-session -t";
      tks = "tmux kill-session -t";

      campus-ssh-toggle = "bash ${ ../../misc/campus-ssh-toggle.sh }";
    };
  };
}
