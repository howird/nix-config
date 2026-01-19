{pkgs, ...}: {
  programs.helix.languages = {
    language = [
      {
        name = "python";
        auto-format = true;
        language-servers = ["ty" "ruff"];
        formatter = {
          command = "${pkgs.ruff}/bin/ruff";
          args = ["format" "-"];
        };
      }
    ];
  };

  home.packages = with pkgs; [
    ruff
    pyright
    ty
  ];
}
