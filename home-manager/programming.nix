{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    zoxide
    eza
    ripgrep
    bat
    fd
    gitui
    ncspot
    (rust-bin.stable.latest.default.override {
      extensions = ["rust-src" "rust-analyzer"];
    })
    nix-index
    devenv
    nixd
  ];

  services.lorri.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
