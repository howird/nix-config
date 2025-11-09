{
  config,
  pkgs,
  ...
}: {
  imports = [./helix.nix ./languages.nix];
  programs.helix = {
    enable = config.myEditor.helix;
    defaultEditor = true;
  };
  # xdg.configFile."helix/config.toml".text = ''
  #   [language-server.ruff]
  #   command = "${pkgs.ruff}"
  #   args = ["server"]

  #   [[language]]
  #   name = "python"
  #   language-servers = ["ruff"]
  #   auto-format = true
  # '';
  # see https://rushter.com/blog/helix-editor/
  # https://github.com/sxyazi/yazi/pull/2461

  home.packages = with pkgs; [
    rustfmt
    pyright
    yazi
  ];
}
