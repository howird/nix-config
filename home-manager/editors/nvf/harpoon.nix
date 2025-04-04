{...}: {
  programs.nvf.settings.vim.navigation.harpoon = {
    enable = true;
    mappings = {
      file1 = "<C-j>";
      file2 = "<C-k>";
      file3 = "<C-l>";
      file4 = "<C-;>";
      listMarks = "<C-e>";
      markFile = "<leader>a";
    };
  };
}
