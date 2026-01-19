{pkgs, ...}: {
  imports = [
    ./typesetting.nix
    ./py.nix
    ./markdown.nix
  ];

  programs.helix.languages = {
    language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.alejandra}/bin/alejandra";
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
  # home.packages = with pkgs; [
  # ];
}
