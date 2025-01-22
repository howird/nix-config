{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./debug.nix
    ./base-keymaps.nix
    ./ext-keymaps.nix
  ];

  programs.nixvim = {
    enable = config.myEditor.nvim;

    plugins.treesitter.enable = true;
    plugins.treesitter-textobjects.enable = true;
    plugins.treesitter-refactor.enable = true;
    plugins.treesitter-context.enable = true;

    plugins.lsp = {
      enable = true;
      servers = {
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
    };
    plugins.rustaceanvim.enable = true;

    plugins.render-markdown.enable = true;
    plugins.web-devicons.enable = true;
    plugins.commentary.enable = true;
    plugins.nvim-surround.enable = true;
    plugins.visual-multi.enable = true;
    plugins.guess-indent.enable = true;

    colorschemes.base16.enable = true;
    plugins.lualine.enable = true;
    plugins.colorizer.enable = true;

    vimAlias = true;

    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 4;
      incsearch = true;
      scrolloff = 8;
    };
  };
}
