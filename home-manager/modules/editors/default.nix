{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./vscode.nix
    ./nvim/nvim.nix
  ];

  programs.nixvim.enable = true;
  programs.vscode.enable = true;
}
