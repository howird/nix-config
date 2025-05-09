{...}: {
  programs.nvf.settings.vim.globals.mapleader = " ";
  programs.nvf.settings.vim.keymaps = [
    {
      key = "J";
      mode = "v";
      action = ":m '>+1<CR>gv=gv";
      desc = "move blocks of text in visual mode with J";
    }
    {
      key = "K";
      mode = "v";
      action = ":m '<-2<CR>gv=gv";
      desc = "move blocks of text in visual mode with K";
    }

    {
      key = "J";
      mode = "n";
      action = "mzJ`z";
      desc = "keeps cursor in the same spot with J";
    }

    {
      key = "H";
      mode = "n";
      action = "Hzz";
      desc = "keeps text centered when H";
    }
    {
      key = "L";
      mode = "n";
      action = "Lzz";
      desc = "keeps text centered when L";
    }
    {
      key = "<C-u>";
      mode = "n";
      action = "<nop>";
      desc = "remove ctrl+u";
    }

    {
      key = "n";
      mode = "n";
      action = "nzzzv";
      desc = "keeps text centered when searching";
    }
    {
      key = "N";
      mode = "n";
      action = "Nzzzv";
      desc = "keeps text centered when searching";
    }

    {
      key = "<leader>p";
      mode = "x";
      action = ''[["_dP]]'';
      lua = true;
      desc = "when replacing highlighted text, cut to void register to preserve current clipboard";
    }
    {
      key = "<leader>d";
      mode = ["n" "v"];
      action = ''[["_d]]'';
      lua = true;
    }

    {
      key = "<leader>y";
      mode = ["n" "v"];
      action = ''[["+y]]'';
      lua = true;
      desc = "yank to system clipboard";
    }
    {
      key = "<leader>Y";
      mode = "n";
      action = ''[["+Y]]'';
      lua = true;
    }

    {
      mode = "n";
      key = "<leader>s";
      action = ''[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]'';
      lua = true;
      desc = "quickly replace current word";
    }

    {
      key = "<leader>x";
      mode = "n";
      action = "<cmd>!chmod +x %<CR>";
      silent = true;
      desc = "chmod +x current file";
    }

    {
      key = "Q";
      mode = "n";
      action = "<nop>";
      desc = "removes capital Q";
    }
  ];
}
