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
    ./nvim-keymaps.nix
  ];

  programs.nixvim = {
    enable = true;

    plugins.treesitter.enable = true;
    plugins.fugitive.enable = true;
    plugins.undotree.enable = true;
    plugins.telescope.enable = true;
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
        rust-analyzer = {
          enable = true;
          installCargo = false;
          installRustc = false;
        };
        lua-ls.enable = true;
        yamlls.enable = true;
      };
    };

    vimAlias = true;

    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 4;
    };
  };
}
