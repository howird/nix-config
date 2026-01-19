{pkgs, ...}: {
  imports = [
    ./vscode
    ./zed
    ./opencode
    ./helix
  ];

  home.packages = with pkgs; [
    claude-code
    code-cursor
  ];
}
