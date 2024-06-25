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
    myShell = {
      fish = lib.mkEnableOption "fish";
      zsh = lib.mkEnableOption "zsh";
      aliases = lib.mkOption {
        type = lib.types.attrs;
        default = {};
      };
    };
  };

  config = {
    myShell.fish = true;
    myShell.zsh = true;

    myShell.aliases = {
      nixwird = "sudo nixos-rebuild switch --flake /home/howird/.config/nix";
      nixwird-hm = "home-manager switch --flake /home/howird/.config/nix";
      nixwird-edit = ''${
          if (with config.myEditor; (vscode || vscodium))
          then "code"
          else "vim"
        } ~/.config/nix'';

      tl = "tmux list-sessions";
      ts = "tmux new-session -s";
      ta = "tmux attach-session -t";
      tks = "tmux kill-session -t";

      campus-ssh-toggle = "bash ${../../misc/campus-ssh-toggle.sh}";

      nixconf = "cd ~/.config/nix";
      vault = "cd ~/vault";
      work = "cd ~/howork";
      code = lib.mkIf config.myEditor.vscodium "codium";
    };
  };
}
