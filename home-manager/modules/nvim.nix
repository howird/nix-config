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
  ];

  programs.nixvim = {
    enable = true;

    plugins.lualine.enable = true;
    colorschemes.onedark.enable = true;

    plugins.treesitter.enable = true;
    plugins.fugitive.enable = true;
    plugins.undotree.enable = true;
    plugins.telescope.enable = true;
    plugins.harpoon.enable = true;

    plugins.lsp = {
      enable = true;
      servers = {
        bashls.enable = true;
        clangd.enable = true;
        # dockerls.enable = true;
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

    globals = {
      mapleader = " ";
    };
  
  };

  programs.nixvim.keymaps = [
    # view project
    { mode = "n";
      key = "<leader>pv";
      action = "vim.cmd.Ex";
      lua = true;
    }

    # move blocks of text in visual mode with shift + J/K
    {
      mode = "v";
      key = "J";
      action = ":m '>+1<CR>gv=gv";
    }
    {
      mode = "v";
      key = "K";
      action = ":m '<-2<CR>gv=gv";
    }

    # keeps cursor in the same spot with shift + J
    {
      mode = "n";
      key = "J";
      action = "mzJ`z";
    }

    # keeps text centered with ctrl + u/d
    {
      mode = "n";
      key = "<C-d>";
      action = "<C-d>zz";
    }
    {
      mode = "n";
      key = "<C-u>";
      action = "<C-u>zz";
    }

    # keeps text centered when searching
    {
      mode = "n";
      key = "n";
      action = "nzzzv";
    }
    {
      mode = "n";
      key = "N";
      action = "Nzzzv";
    }

    # when replacing highlighted text, cut to void register to preserve current clipboard
    {
      mode = "x";
      key = "<leader>p";
      action = ''[["_dP]]'';
      lua = true;
    }
    {
      mode = ["n" "v"];
      key = "<leader>d";
      action = ''[["_d]]'';
      lua = true;
    }

    # yank to system clipboard
    {
      mode = ["n" "v"];
      key = "<leader>y";
      action = ''[["+y]]'';
      lua = true;
    }
    {
      mode = "n";
      key = "<leader>Y";
      action = ''[["+Y]]'';
      lua = true;
    }

    # makes ctrl + c save and exit vertical insert mode
    {
      mode = "i";
      key = "<C-c>";
      action = "<Esc>";
    }

    # removes capital Q
    {
      mode = "n";
      key = "Q";
      action = "<nop>";
    }

    # makes new tmux session
    {
      mode = "n";
      key = "<C-f>";
      action = "<cmd>silent !tmux neww tmux-sessionizer<CR>";
    }

    {
      mode = "n";
      key = "<leader>f";
      action = "vim.lsp.buf.format";
      lua = true;
    }

    # quickfix navigation
    {
      mode = "n";
      key = "<C-k>";
      action = "<cmd>cnext<CR>zz";
    }
    {
      mode = "n";
      key = "<C-j>";
      action = "<cmd>cprev<CR>zz";
    }
    {
      mode = "n";
      key = "<leader>k";
      action = "<cmd>lnext<CR>zz";
    }
    {
      mode = "n";
      key = "<leader>j";
      action = "<cmd>lprev<CR>zz";
    }

    # quickly replace current word
    {
      mode = "n";
      key = "<leader>s";
      action = "[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]";
      lua = true;
    }

    # chmod +x current file
    {
      mode = "n";
      key = "<leader>x";
      action = "<cmd>!chmod +x %<CR>";
      options = { silent = true; };
    }

    # git
    {
      mode = "n";
      key = "<leader>gs";
      action = "vim.cmd.Git";
      lua = true;
    }

    # undotree
    {
      mode = "n";
      key = "<leader>u";
      action = "vim.cmd.UndotreeToggle";
      lua = true;
    }

    # telescope
    {
      mode = "n";
      key ="<leader>pf";
      action = "require('telescope.builtin').find_files";
      lua = true;
    }
    {
      mode = "n";
      key ="<C-p>";
      action = "require('telescope.builtin').git_files";
      lua = true;
    }
    {
      mode = "n";
      key ="<leader>ps";
      action = ''
      function()
        require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") })
      end
      '';
      lua = true;
    }
    {
      mode = "n";
      key = "<leader>vh";
      action = "require('telescope.builtin').help_tags";
      lua = true;
    }

    # harpoon
    { 
      mode = "n";
      key = "<leader>a";
      action = "require('harpoon.mark').add_file";
      lua = true;
    }
    { 
      mode = "n";
      key = "<C-e>";
      action = "require('harpoon.ui').toggle_quick_menu";
      lua = true;
    }
    {
      mode = "n";
      key = "<C-h>";
      action = "function() require('harpoon.ui').nav_file(1) end";
      lua = true;
    }
    {
      mode = "n";
      key = "<C-j>";
      action = "function() require('harpoon.ui').nav_file(2) end";
      lua = true;
    }
    {
      mode = "n";
      key = "<C-k>";
      action = "function() require('harpoon.ui').nav_file(3) end";
      lua = true;
    }
    {
      mode = "n";
      key = "<C-l>";
      action = "function() require('harpoon.ui').nav_file(4) end";
      lua = true;
    }
  ];
}
