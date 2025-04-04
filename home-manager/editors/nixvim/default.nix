{
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./lsp.nix
    ./debug.nix
    ./base-keymaps.nix
    ./ext-keymaps.nix
  ];

  programs.nixvim = {
    enable = config.myEditor.nvim;

    plugins.render-markdown.enable = true;
    plugins.web-devicons.enable = true;
    plugins.commentary.enable = true;
    plugins.nvim-surround.enable = true;
    plugins.visual-multi.enable = true;
    plugins.guess-indent.enable = true;

    colorschemes.base16.enable = true;
    plugins.lualine.enable = true;
    plugins.colorizer.enable = true;

    # vimAlias = true;

    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 4;
      incsearch = true;
      scrolloff = 8;
    };
  };
}
