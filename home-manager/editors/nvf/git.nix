{
  programs.nvf.settings.vim = {
    git = {
      enable = true;
      gitsigns.enable = true;
      gitsigns.codeActions.enable = false;

      git-conflict.enable = true;
      git-conflict.mappings = {
        both = "<leader>cb";
        nextConflict = "[x";
        none = "<leader>c0";
        ours = "<leader>co";
        prevConflict = "]x";
        theirs = "<leader>ct";
      };

      vim-fugitive.enable = true;
    };
    keymaps = [
      {
        key = "<leader>gs";
        mode = ["n"];
        action = ":Git<CR>";
        silent = true;
        desc = "open fugitive";
      }
    ];
  };
}
