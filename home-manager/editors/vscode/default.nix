{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./extensions.nix
    ./settings.nix
  ];

  config = {
    programs.vscode = {
      enable = config.myEditor.vscode || config.myEditor.vscodium;
      package =
        (
          if config.myEditor.vscode
          then pkgs.vscode
          else pkgs.vscodium
        )
        .override {
          commandLineArgs = [
            "--enable-features=UseOzonePlatform"
            "--ozone-platform=wayland"
          ];
        };
    };
  };
}
