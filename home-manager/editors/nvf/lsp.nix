{...}: {
  programs.nvf.settings.vim = {
    lsp.enable = true;
    lsp.formatOnSave = true;

    languages = {
      enableLSP = true;
      enableDAP = true;
      enableFormat = true;
      enableTreesitter = true;
      enableExtraDiagnostics = true;

      python.enable = true;
      python.lsp.server = "pyright";
      nix.enable = true;
      nix.lsp.server = "nixd";
      rust.enable = true;
      clang.enable = true;
      html.enable = true;
      # dart.enable = true;
      # go.enable = true;
      # lua.enable = true;
      # ts.enable = true;
      markdown.enable = true;
      markdown.extensions.render-markdown-nvim.enable = true;
    };

    autocomplete.blink-cmp = {
      enable = true;
      friendly-snippets.enable = true;
      mappings = {
        close = "<C-n>";
        complete = "<C-l";
        confirm = "<CR>";
        next = "<Tab>";
        previous = "<S-Tab>";
        scrollDocsUp = "<C-d>";
        scrollDocsDown = "<C-f>";
      };
      sourcePlugins = {
        ripgrep.enable = true;
        spell.enable = true;
      };
    };

    lsp.mappings = {
      addWorkspaceFolder = "<leader>lwa";
      codeAction = "<leader>la";
      documentHighlight = "<leader>lH";
      format = "<leader>lf";

      goToDeclaration = "<leader>gD";
      goToDefinition = "<leader>gd";
      goToType = "<leader>gt";
      hover = "<leader>h";

      openDiagnosticFloat = "<leader>e";
      nextDiagnostic = "<leader>j";
      previousDiagnostic = "<leader>k";

      listDocumentSymbols = "<leader>lS";
      listImplementations = "<leader>li";
      listReferences = "<leader>lr";
      listWorkspaceFolders = "<leader>lwl";
      listWorkspaceSymbols = "<leader>lws";

      removeWorkspaceFolder = "<leader>lwr";
      renameSymbol = "<leader>ln";
      signatureHelp = "<leader>ls";
      toggleFormatOnSave = "<leader>ltf";
    };

    keymaps = [
      {
        key = "<leader>lr";
        mode = "n";
        action = ":LspRestart<CR>";
        silent = true;
        desc = "restart lsp";
      }
    ];
  };
}
