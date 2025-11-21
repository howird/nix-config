{pkgs, ...}: {
  imports = [
    ./extensions.nix
    ./settings.nix
  ];

  programs.vscode = {
    package = pkgs.vscode.override {
      commandLineArgs = [
        "--enable-features=UseOzonePlatform"
        "--ozone-platform=wayland"
      ];
    };
  };
}
