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
    inputs.claude-code.packages.${system}.default

    kiro-fhs
    kiro-cli

    antigravity-cli
  ];
}
