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
        formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
      }
    ];
  };
  # home.packages = with pkgs; [
  #   rustfmt
  #   pyright
  # ];
}
