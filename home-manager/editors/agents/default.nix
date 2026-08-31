{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    inputs.pi.packages.${system}.default

    inputs.claude-desktop.packages.${system}.claude-desktop
    inputs.claude-code.packages.${system}.default

    kiro-fhs
    kiro-cli

    antigravity-cli
  ];
}
