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
    ./keymaps.nix
  ];

  programs.nixvim = lib.mkIf config.myEditor.nvim {
    enable = true;
    plugins.treesitter.enable = true;
    plugins.fugitive.enable = true;
    plugins.undotree.enable = true;
    plugins.telescope.enable = true;
    plugins.web-devicons.enable = true;
    plugins.harpoon.enable = true;

    plugins.lualine.enable = true;
    colorschemes.onedark.enable = true;

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
