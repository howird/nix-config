{pkgs, ...}: {
  home.packages = with pkgs; [
    fzf
    zoxide
    eza
    ripgrep
    bat
    fd
    lazygit
    (rust-bin.stable.latest.default.override {
      extensions = ["rust-src" "rust-analyzer"];
    })

    devenv
    nixd
    uv
    textpieces
  ];

  services.lorri.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
