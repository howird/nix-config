{...}: {
  programs.nvf.settings.vim = {
    navigation.harpoon = {
      enable = true;
      mappings = {
        listMarks = "<C-e>";
        markFile = "<leader>a";
        file1 = "<C-a>";
        file2 = "<C-s>";
        file3 = "<C-d>";
        file4 = "<C-f>";
      };
    };
    keymaps = [
      {
        key = "<C-k>";
        mode = "n";
        action = "function() require('harpoon'):list():prev() end";
        lua = true;
        desc = "Harpoon prev";
      }
      {
        key = "<C-j>";
        mode = "n";
        action = "function() require('harpoon'):list():next() end";
        lua = true;
        desc = "Harpoon next";
      }
    ];
  };
}
