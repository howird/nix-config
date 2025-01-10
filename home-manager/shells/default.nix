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
    ./tmux.nix
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
      uw-vpn = "sudo openconnect -v cn-vpn.uwaterloo.ca";

      tl = "tmux list-sessions";
      ts = "tmux new-session -s";
      ta = "tmux attach-session -t";
      tks = "tmux kill-session -t";

      ls = "exa";
      ll = "exa -l";
      la = "exa -la";
      tree = "exa --tree";
      cat = "bat";

      code = lib.mkIf config.myEditor.vscodium "codium";
    };

    home.packages = with pkgs; [
      (writeShellScriptBin "tat" (builtins.readFile ./scripts/tat))
      (writeShellScriptBin "campus-ssh-toggle" (builtins.readFile ./scripts/campus-ssh-toggle))
    ];

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
