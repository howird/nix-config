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
    ./keymaps.nix
  ];

  programs.nixvim = {
    enable = config.myEditor.nvim;

    plugins.oil.enable = true;
    plugins.treesitter.enable = true;
    plugins.undotree.enable = true;
    plugins.fugitive.enable = true;
    plugins.telescope.enable = true;
    plugins.harpoon.enable = true;

    plugins.web-devicons.enable = true;
    plugins.commentary.enable = true;
    plugins.nvim-surround.enable = true;
    plugins.guess-indent.enable = true;

    colorschemes.base16.enable = true;
    plugins.lualine.enable = true;
    plugins.colorizer.enable = true;

    plugins.lsp = {
      enable = true;
      servers = {
        bashls.enable = true;
        clangd.enable = true;
        dockerls.enable = true;
        html.enable = true;
        jsonls.enable = true;
        pyright.enable = true;
        rust_analyzer = {
          enable = true;
          installCargo = false;
          installRustc = false;
        };
        lua_ls.enable = true;
        yamlls.enable = true;
      };
    };

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
