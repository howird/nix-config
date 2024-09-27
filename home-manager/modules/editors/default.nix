{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./vscode
    ./nvim
  ];

  options = {
    myEditor = {
      vscode = lib.mkEnableOption "vscode";
      vscodium = lib.mkEnableOption "vscodium";
      nvim = lib.mkEnableOption "nvim";
    };
  };
}
