{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.nixvim = {
    plugins.dap.enable = true;
    plugins.dap.extensions.dap-ui.enable = true;
    plugins.dap.extensions.dap-virtual-text.enable = true;
    plugins.dap.extensions.dap-python.enable = true;
    plugins.dap.extensions.dap-python.adapterPythonPath = "python3";
    plugins.dap-lldb.enable = true;
    
    keymaps = [
      {
        mode = "n";
        key = "<leader>ds";
        action = "<cmd>lua require('dap').continue()<CR>";
      }
      {
        mode = "n";
        key = "<leader>db";
        action = "<cmd>DapToggleBreakpoint<CR>";
      }
    ];
  };
}
