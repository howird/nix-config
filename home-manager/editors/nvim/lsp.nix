{...}: {
  programs.nixvim = {
    plugins.lsp.enable = true;

    plugins.lsp.keymaps = {
      diagnostic = {
        "<leader>j" = "goto_next";
        "<leader>k" = "goto_prev";
      };
      lspBuf = {
        K = "hover";
        gD = "references";
        gd = "definition";
        gi = "implementation";
        gt = "type_definition";
      };
    };

    keymaps = [
      # show full diagnostic msg when it is cut off
      {
        mode = "n";
        key = "<leader>ls";
        action = "<cmd>lua vim.diagnostic.open_float()<CR>";
      }
      {
        mode = "n";
        key = "<leader>lk";
        action = "<cmd>lua vim.diagnostic.goto_prev()<CR>";
      }
      {
        mode = "n";
        key = "<leader>lj";
        action = "<cmd>lua vim.diagnostic.goto_next()<CR>";
      }
      {
        mode = "n";
        key = "<leader>lr";
        action = "<cmd>LspRestart<CR>";
      }
    ];

    plugins.lsp.servers = {
      bashls.enable = true;
      clangd.enable = true;
      cssls.enable = true;
      dockerls.enable = true;
      html.enable = true;
      jsonls.enable = true;
      lua_ls.enable = true;
      nixd.enable = true;
      pyright.enable = true;
      svelte.enable = true;
      yamlls.enable = true;
    };
    plugins.rustaceanvim.enable = true;

    plugins.treesitter.enable = true;
    plugins.treesitter-textobjects.enable = true;
    plugins.treesitter-refactor.enable = true;
    plugins.treesitter-context.enable = true;

    plugins.cmp.enable = true;
    plugins.cmp-nvim-lsp.enable = true;
    plugins.cmp-treesitter.enable = true;
  };
}
