{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  host,
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
      hmFlakeArgs = lib.mkOption {
        type = lib.types.str;
        default = "";
      };
    };
  };

  config = {
    myShell.aliases = {
      nixwird-edit = ''${
          if (with config.myEditor; (vscode || vscodium))
          then "code"
          else "vim"
        } ~/nix/config'';

      tl = "tmux list-sessions";
      ts = "tmux new-session -s";
      ta = "tmux attach-session -t";
      tks = "tmux kill-session -t";

      campus-ssh-toggle = "bash ${./scripts/campus-ssh-toggle.sh}";
      uw-vpn = "sudo openconnect -v cn-vpn.uwaterloo.ca";

      ls = "exa";
      ll = "exa -l";
      la = "exa -la";
      cat = "bat";

      code = lib.mkIf config.myEditor.vscodium "codium";
    };

    programs.direnv = {
      enableZshIntegration = config.myShell.zsh;
      enableFishIntegration = config.myShell.fish;
    };
    programs.fzf = {
      enableZshIntegration = config.myShell.zsh;
      enableFishIntegration = config.myShell.fish;
    };
  };
}
