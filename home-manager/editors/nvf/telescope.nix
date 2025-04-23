{...}: {
  programs.nvf.settings.vim = {
    telescope = {
      enable = true;
      mappings = {
        liveGrep = "<leader>ff";
        findFiles = "<leader>fp";
        findProjects = "<leader>fw";

        open = "<leader>ft";
        buffers = "<leader>fb";
        diagnostics = "<leader>fld";
        helpTags = "<leader>fh";

        resume = "<leader>fr";
        treesitter = "<leader>fs";
      };
      setupOpts.defaults.file_ignore_patterns = [".venv/" ".aider%" "wandb"];
    };
    keymaps = [
      {
        key = "<C-p>";
        mode = "n";
        action = ":Telescope git_files<CR>";
        desc = "search for git files";
      }
      {
        key = "<leader>ps";
        mode = "n";
        action = ''
          function()
            require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") })
          end
        '';
        lua = true;
        desc = "global search for string";
      }
    ];
  };
}
