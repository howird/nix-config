{...}: {
  programs.nvf.settings.vim.navigation.harpoon = {
    enable = true;
    mappings = {
      file1 = "<C-h>";
      file2 = "<C-j>";
      file3 = "<C-k>";
      file4 = "<C-l>";
      listMarks = "<C-e>";
      markFile = "<leader>a";
    };
    # setupOpts.defaults.save_on_toggle = true;
    # setupOpts.defaults.sync_on_ui_close = true;
  };
}
