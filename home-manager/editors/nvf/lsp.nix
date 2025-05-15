{...}: {
  programs.nvf.settings.vim = {
    lsp.enable = true;
    lsp.formatOnSave = true;

    autocomplete.blink-cmp = {
      enable = true;
      friendly-snippets.enable = true;
      mappings = {
        close = "<C-n>";
        complete = "<C-m>";
        confirm = "<CR>";
        next = "<Tab>";
        previous = "<S-Tab>";
        scrollDocsUp = null;
        scrollDocsDown = null;
      };
      sourcePlugins = {
        ripgrep.enable = true;
        spell.enable = true;
      };
    };

    telescope.mappings = {
      lspDefinitions = "<leader>lD";
      lspDocumentSymbols = "<leader>ls";
      lspImplementations = "<leader>li";
      lspReferences = "<leader>lr";
      lspTypeDefinitions = "<leader>lt";
      lspWorkspaceSymbols = "<leader>lws";
    };

    lsp.mappings = {
      addWorkspaceFolder = "<leader>lwa";
      codeAction = "<leader>la";
      documentHighlight = "<leader>lH";
      format = "<leader>lf";

      goToDeclaration = "<leader>gD";
      goToDefinition = "<leader>gd";
      goToType = "<leader>gt";

      hover = "<leader>lh";
      openDiagnosticFloat = "<leader>e";
      nextDiagnostic = "<leader>j";
      previousDiagnostic = "<leader>k";

      listDocumentSymbols = null;
      listImplementations = null;
      listReferences = null;
      listWorkspaceFolders = "<leader>lwl";
      listWorkspaceSymbols = null;

      removeWorkspaceFolder = "<leader>lwr";
      renameSymbol = "<leader>ln";
      signatureHelp = "<leader>ls";
      toggleFormatOnSave = "<leader>ltf";
    };

    keymaps = [
      {
        key = "<leader>lR";
        mode = "n";
        action = ":LspRestart<CR>";
        silent = true;
        desc = "restart lsp";
      }
    ];
  };
}
