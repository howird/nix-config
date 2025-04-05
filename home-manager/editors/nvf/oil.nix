{...}: {
  programs.nvf.settings.vim = {
    utility.oil-nvim.enable = true;
    utility.oil-nvim.setupOpts = {
      use_default_keymaps = false;
      view_options.show_hidden = true;
      keymaps = {
        "g?" = "actions.show_help";
        "<CR>" = "actions.select";
        "<leader>%" = "actions.select_vsplit";
        "<leader>\"" = "actions.select_split";
        "<C-t>" = "actions.select_tab";
        "=" = "actions.preview";
        "<C-c>" = "actions.close";
        "<C-l>" = "actions.refresh";
        "-" = "actions.parent";
        "_" = "actions.open_cwd";
        "`" = "actions.cd";
        "~" = "actions.tcd";
        "gs" = "actions.change_sort";
        "gx" = "actions.open_external";
        "g." = "actions.toggle_hidden";
        "g\\" = "actions.toggle_trash";
      };
    };
    keymaps = [
      {
        key = "-";
        mode = ["n"];
        action = ":Oil<CR>";
        silent = true;
        desc = "open oil";
      }
    ];
  };
}
