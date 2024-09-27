{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./settings.nix
    ./extensions.nix
  ];

  config = {
    programs.vscode = lib.mkIf (config.myEditor.vscode || config.myEditor.vscodium) {
      enable = true;
      package =
        if config.myEditor.vscode
        then pkgs.vscode
        else pkgs.vscodium;
    };
  };
}
