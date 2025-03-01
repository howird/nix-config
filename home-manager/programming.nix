{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    fzf
    zoxide
    eza
    ripgrep
    bat
    fd
    lazygit
    ncspot
    (rust-bin.stable.latest.default.override {
      extensions = ["rust-src" "rust-analyzer"];
    })
    nix-index
    devenv
    nixd
    pixi
    uv
  ];

  services.lorri.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
