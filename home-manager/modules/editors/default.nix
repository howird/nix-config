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

  options = {
    myEditor = {
      vscode = lib.mkEnableOption "vscode";
      vscodium = lib.mkEnableOption "vscodium";
      nvim = lib.mkEnableOption "nvim";
    };
  };
}
