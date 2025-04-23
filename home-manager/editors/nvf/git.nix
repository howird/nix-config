{
  programs.nvf.settings.vim = {
    git = {
      enable = true;
      gitsigns.enable = true;
      gitsigns.codeActions.enable = false;
      git-conflict.enable = true;
      vim-fugitive.enable = true;
    };
    git.gitsigns.mappings = {
      blameLine = "<leader>hb";
      diffProject = "<leader>hD";
      diffThis = "<leader>hd";

      nextHunk = "<leader>hj";
      previousHunk = "<leader>hk";
      previewHunk = "<leader>hh";

      resetHunk = "<leader>hr";
      resetBuffer = "<leader>hR";
      stageHunk = "<leader>hs";
      stageBuffer = "<leader>hS";
      undoStageHunk = "<leader>hu";

      toggleBlame = "<leader>tb";
      toggleDeleted = "<leader>td";
    };
    telescope.mappings = {
      gitBranches = "<leader>fgb";
      gitBufferCommits = "<leader>fgf";
      gitCommits = "<leader>fgc";
      gitStash = "<leader>fgx";
      gitStatus = "<leader>fgs";
    };
    git.git-conflict.mappings = {
      both = "<leader>cb";
      nextConflict = "[x";
      none = "<leader>c0";
      ours = "<leader>co";
      prevConflict = "]x";
      theirs = "<leader>ct";
    };
    keymaps = [
      {
        key = "<leader>gs";
        mode = ["n"];
        action = ":Git<CR>";
        silent = true;
        desc = "open fugitive";
      }
      {
        key = "<leader>gv";
        mode = ["n"];
        action = ":Gvdiff<CR>";
        silent = true;
        desc = "Fugitive vertical split";
      }
    ];
  };
}
