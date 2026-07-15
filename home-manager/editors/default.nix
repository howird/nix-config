{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./helix
    ./vscode
    ./zed
  ];

  home.packages = with pkgs; [
    inputs.claude-desktop.packages.${system}.claude-desktop
    claude-code
    antigravity-cli
    codex
  ];
}
