{
  programs.nixvim = {
    plugins.dap.enable = true;
    plugins.dap-ui.enable = true;
    plugins.dap-virtual-text.enable = true;
    plugins.dap-python.enable = true;
    plugins.dap-python.adapterPythonPath = "python3";
    plugins.dap-lldb.enable = true;
    plugins.cmp-dap.enable = true;

    keymaps = [
      {
        mode = "n";
        key = "<leader>dc";
        action = ":DapContinue<CR>";
      }
      {
        mode = "n";
        key = "<leader>b";
        action = "<cmd>DapToggleBreakpoint<CR>";
      }
      {
        mode = "n";
        key = "<leader>db";
        action = "<cmd>lua require('dap').run_to_cursor()<CR>";
      }
      {
        mode = "n";
        key = "<leader>do";
        action = "<cmd>lua require('dap').up()<CR>";
      }
      {
        mode = "n";
        key = "<leader>di";
        action = "<cmd>lua require('dap').down()<CR>";
      }
      {
        mode = "n";
        key = "<leader>dh";
        action = "<cmd>lua require('dap').step_back()<CR>";
      }
      {
        mode = "n";
        key = "<leader>dj";
        action = ":DapStepInto<CR>";
      }
      {
        mode = "n";
        key = "<leader>dk";
        action = ":DapStepOut<CR>";
      }
      {
        mode = "n";
        key = "<leader>dl";
        action = ":DapStepOver<CR>";
      }
      {
        mode = "n";
        key = "<leader>dr";
        action = ":DapToggleRepl<CR>";
      }
      {
        mode = "n";
        key = "<leader>du";
        action = "<cmd>lua require('dapui').toggle()<CR>";
      }
    ];
  };
}
