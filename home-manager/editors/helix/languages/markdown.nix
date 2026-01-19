{pkgs, ...}: {
  programs.helix.languages = {
    language = [
      {
        name = "markdown";
        auto-format = true;
        formatter = {
          command = "rumdl";
          args = ["fmt" "--stdin"];
        };
        comment-tokens = ["-" "+" "*" "- [ ]" ">"];
      }
    ];
  };

  home.packages = with pkgs; [
    marksman
    markdown-oxide
    rumdl
    harper
  ];
}
