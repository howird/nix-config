{
  programs.nvf.settings.vim = {
    languages = {
      enableDAP = true;
      python.dap.enable = true;
      python.dap.debugger = "debugpy";
      rust.dap.enable = true;
    };
    debugger = {
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
  };
}
