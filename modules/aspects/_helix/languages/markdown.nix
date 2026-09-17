{pkgs, ...}: {
  programs.helix.languages = {
    language = [
      {
        name = "markdown";
        language-servers = ["markdown-oxide" "rumdl"];
        auto-format = true;
        rulers = [];
        formatter = {
          command = "rumdl";
          args = ["fmt" "--stdin"];
        };
        comment-tokens = ["-" "+" "*" "- [ ]" "- [x]" ">"];
      }
    ];
  };

  home.packages = with pkgs; [
    markdown-oxide
    rumdl
    harper
  ];
}
