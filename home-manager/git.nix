{
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    lfs.enable = true;
    ignores = [
      "**/.aider*"
    ];
    settings = {
      core.editor = "hx";
      pull.ff = "only";
      user = {
        name = "Howard Nguyen-Huu";
        email = config.myEmail;
      };
      aliases = {
        ci = "commit";
        co = "checkout";
        s = "status";
      };
    };
  };

  home.packages = with pkgs; [
    git-filter-repo
    gitui
    lazygit
  ];
}
