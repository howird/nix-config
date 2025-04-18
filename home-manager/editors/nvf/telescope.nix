{...}: {
  programs.nvf.settings.vim = {
    telescope = {
      enable = true;
      mappings = {
        open = "<leader>ft";
        buffers = "<leader>fb";
        diagnostics = "<leader>fld";
        findFiles = "<leader>ff";
        findProjects = "<leader>fp";
        gitBranches = "<leader>fvb";
        gitBufferCommits = "<leader>fvcb";
        gitCommits = "<leader>fvcw";
        gitStash = "<leader>fvx";
        gitStatus = "<leader>fvs";
        helpTags = "<leader>fh";
        liveGrep = "<leader>fg";
        lspDefinitions = "<leader>flD";
        lspDocumentSymbols = "<leader>flsb";
        lspImplementations = "<leader>fli";
        lspReferences = "<leader>flr";
        lspTypeDefinitions = "<leader>flt";
        lspWorkspaceSymbols = "<leader>flsw";
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
