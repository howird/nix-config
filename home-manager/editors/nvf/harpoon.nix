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
        key = "<C-S-k>";
        mode = "n";
        action = "function() require('harpoon'):list():prev() end";
        lua = true;
        desc = "Harpoon prev";
      }
      {
        key = "<C-S-j>";
        mode = "n";
        action = "function() require('harpoon'):list():next() end";
        lua = true;
        desc = "Harpoon next";
      }
    ];
  };
}
