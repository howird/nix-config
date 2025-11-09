{pkgs, ...}: {
  programs.helix.languages = {
    language = [
      {
        name = "typst";
        auto-format = true;
        formatter = {
          command = "${pkgs.typstyle}/bin/typstyle";
          args = ["--wrap-text"];
        };
      }
      {
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.alejandra}/bin/alejandra";
      }
    ];
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

  # home.packages = with pkgs; [
  #   rustfmt
  #   pyright
  # ];
}
