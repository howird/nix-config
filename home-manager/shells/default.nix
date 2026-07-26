{
  inputs,
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
      (writeShellScriptBin "link2epub" (builtins.readFile ./scripts/link2epub))
    ];

    # Point legacy `<nixpkgs>` lookups (nix-shell, nix-instantiate, etc) at the
    # exact nixpkgs revision pinned in this flake's flake.lock, so they never
    # drift from what nixos-rebuild/home-manager actually build
    home.sessionVariables.NIX_PATH = "nixpkgs=${inputs.nixpkgs}:home-manager=${inputs.home-manager}";
  };
}
