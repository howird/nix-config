{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./starship
    ./tmux
    ./zellij

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
      uw-vpn = "sudo openconnect -v cn-vpn.uwaterloo.ca";

      tl = "tmux list-sessions";
      ts = "tmux new-session -s";
      ta = "tmux attach-session -t";
      tks = "tmux kill-session -t";

      tree = "eza --tree";

      cat = "bat";

      code = lib.mkIf config.myEditor.vscodium "codium";
    };

    home.packages = with pkgs; [
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
