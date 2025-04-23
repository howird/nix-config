{...}: {
  programs.nvf.settings.vim.languages = {
    enableFormat = true;
    enableTreesitter = true;
    enableExtraDiagnostics = true;

    python.enable = true;
    python.lsp.enable = true;
    python.lsp.server = "pyright";
    python.format.enable = true;
    python.format.type = "ruff";
    python.treesitter.enable = true;

    nix.enable = true;
    nix.lsp.enable = true;
    nix.format.enable = true;
    nix.treesitter.enable = true;

    rust.enable = true;
    rust.lsp.enable = true;
    rust.format.enable = true;
    rust.treesitter.enable = true;

    clang.enable = true;
    html.enable = true;
    # dart.enable = true;
    # go.enable = true;
    # lua.enable = true;
    # ts.enable = true;

    markdown.enable = true;
    markdown.extensions.render-markdown-nvim.enable = true;
  };
}
