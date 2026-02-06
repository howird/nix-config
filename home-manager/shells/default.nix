{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./starship
    ./zellij

    ./fish.nix
    ./zsh.nix
  ];

  options = {
    myShell = {
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
      tree = "eza --tree";
      cat = "bat";
    };

    home.packages = with pkgs; [
      (writeShellScriptBin "nv-users" (builtins.readFile ./scripts/nv-users))
    ];
  };
}
