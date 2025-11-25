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
      {
        name = "python";
        auto-format = true;
        language-servers = ["ty" "ruff"];
        formatter = {
          command = "${pkgs.ruff}/bin/ruff";
          args = ["format" "-"];
        };
      }
      {
        name = "markdown";
        auto-format = true;
        formatter = {
          command = "${pkgs.deno}/bin/deno";
          args = ["fmt" "-" "--ext" "md"];
        };
      }
      {
        name = "rust";
        auto-format = true;
      }
      {
        name = "cpp";
        auto-format = true;
      }
      {
        name = "c";
        auto-format = true;
      }
    ];
  };

  home.packages = with pkgs; [
    ruff
    pyright
    ty
    marksman
  ];
}
