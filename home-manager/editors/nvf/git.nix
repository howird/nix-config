{...}: {
  programs.nvf.settings.vim = {
    git.enable = true;
    git.gitsigns.enable = true;
    git.gitsigns.codeActions.enable = false;

    git.vim-fugitive.enable = true;
    keymaps = [
      {
        key = "<leader>gs";
        mode = ["n"];
        action = ":Git<CR>";
        silent = true;
        desc = "open fugitive";
      }
    ];

    git.git-conflict.enable = true;
    git.git-conflict.mappings = {
      both = "<leader>cb";
      nextConflict = "[x";
      none = "<leader>c0";
      ours = "<leader>co";
      prevConflict = "]x";
      theirs = "<leader>ct";
    };
  };
}
