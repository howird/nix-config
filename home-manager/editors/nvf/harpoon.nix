{...}: {
  programs.nvf.settings.vim = {
    navigation.harpoon = {
      enable = true;
      mappings = {
        listMarks = "<C-e>";
        markFile = "<leader>a";
        file1 = "<C-h>";
        file2 = "<C-j>";
        file3 = "<C-k>";
        file4 = "<C-l>";
      };
    };
    keymaps = [
      {
        key = "<C-;>";
        mode = "n";
        action = "<cmd>lua require('harpoon'):list():select(5)<CR>";
        desc = "Go to marked file 5 [Harpoon]";
      }
      {
        key = "<C-S-k>";
        mode = "n";
        action = "<cmd>lua require('harpoon'):list():prev()<CR>";
        desc = "Harpoon prev";
      }
      {
        key = "<C-S-j>";
        mode = "n";
        action = "<cmd>lua require('harpoon'):list():next()<CR>";
        desc = "Harpoon next";
      }
    ];
  };
}
