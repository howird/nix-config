{...}: {
  programs.nvf.settings.vim.languages = {
    enableFormat = true;
    enableTreesitter = true;
    enableExtraDiagnostics = true;

    python.enable = true;
    python.format.type = "ruff";
    nix.enable = true;
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
}
