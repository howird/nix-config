{pkgs, ...}: {
  imports = [
    ./helix
    ./vscode
    ./zed
  ];

  home.packages = with pkgs; [
    claude-code
    antigravity-cli
    codex
  ];
}
