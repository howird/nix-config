{
  programs.nvf.settings.vim.debugger = {
    nvim-dap.enable = true;
    nvim-dap.ui.enable = true;

    nvim-dap.mappings = {
      toggleDapUI = "<leader>du";
      toggleRepl = "<leader>dr";

      toggleBreakpoint = "<leader>b";
      continue = "<leader>dc";
      hover = "<leader>dh";
      runToCursor = "<leader>db";

      goDown = "<leader>di";
      goUp = "<leader>do";

      stepBack = "<leader>dh";
      stepOver = "<leader>dl";
      stepInto = "<leader>dj";
      stepOut = "<leader>dj";
    };
  };
}
