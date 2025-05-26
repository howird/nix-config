{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./fish.nix
    ./zsh.nix
    ./starship
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

      ls = "eza";
      ll = "eza -l";
      la = "eza -la";
      tree = "eza --tree";

      cat = "bat";

      code = lib.mkIf config.myEditor.vscodium "codium";
    };

    home.packages = with pkgs; [
      (writeShellScriptBin "campus-ssh-toggle" (builtins.readFile ./scripts/campus-ssh-toggle))
      (writeShellScriptBin "nv-users" (builtins.readFile ./scripts/nv-users))
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
