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
  };
}
