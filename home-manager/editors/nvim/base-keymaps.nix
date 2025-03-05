{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.myEditor.nvim {
    programs.nixvim.globals.mapleader = " ";
    programs.nixvim.keymaps = [
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
        action.__raw = ''[["_dP]]'';
      }
      {
        mode = ["n" "v"];
        key = "<leader>d";
        action.__raw = ''[["_d]]'';
      }

      # yank to system clipboard
      {
        mode = ["n" "v"];
        key = "<leader>y";
        action.__raw = ''[["+y]]'';
      }
      {
        mode = "n";
        key = "<leader>Y";
        action.__raw = ''[["+Y]]'';
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
        action.__raw = "vim.lsp.buf.format";
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
        action.__raw = "[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]";
      }

      # chmod +x current file
      {
        mode = "n";
        key = "<leader>x";
        action = "<cmd>!chmod +x %<CR>";
        options = {silent = true;};
      }
    ];
  };
}
