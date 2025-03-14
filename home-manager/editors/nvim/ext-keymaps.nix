{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.myEditor.nvim {
    programs.nixvim = {
      plugins.oil.enable = true;
      plugins.fugitive.enable = true;
      plugins.undotree.enable = true;
      plugins.telescope.enable = true;
      plugins.harpoon.enable = true;

      plugins.oil.settings.use_default_keymaps = false;
      plugins.oil.settings.view_options.show_hidden = true;
      plugins.oil.settings.keymaps = {
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
      keymaps = [
        # oil
        {
          mode = "n";
          key = "-";
          action = "<cmd>Oil<CR>";
        }
        {
          mode = "n";
          key = "<leader>-";
          action = "<cmd>Oil --floating<CR>";
        }

        # git
        {
          mode = "n";
          key = "<leader>gs";
          action = "<cmd>Git<CR>";
        }

        # undotree
        {
          mode = "n";
          key = "<leader>u";
          action = "<cmd>UndotreeToggle<CR>";
        }

        # telescope
        {
          mode = "n";
          key = "<C-p>";
          action = "<cmd>Telescope git_files<CR>";
        }
        {
          mode = "n";
          key = "<leader>pf";
          action = "<cmd>Telescope find_files<CR>";
        }
        {
          mode = "n";
          key = "<leader>pb";
          action = "<cmd>Telescope buffers<CR>";
        }
        {
          mode = "n";
          key = "<leader>ps";
          action.__raw = ''
            function()
              require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") })
            end
          '';
        }
        {
          mode = "n";
          key = "<leader>vh";
          action = "<cmd>Telescope help_tags<CR>";
        }

        # harpoon
        {
          mode = "n";
          key = "<leader>a";
          action.__raw = "require('harpoon.mark').add_file";
        }
        {
          mode = "n";
          key = "<C-e>";
          action.__raw = "require('harpoon.ui').toggle_quick_menu";
        }
        {
          mode = "n";
          key = "<C-h>";
          action.__raw = "function() require('harpoon.ui').nav_file(1) end";
        }
        {
          mode = "n";
          key = "<C-j>";
          action.__raw = "function() require('harpoon.ui').nav_file(2) end";
        }
        {
          mode = "n";
          key = "<C-k>";
          action.__raw = "function() require('harpoon.ui').nav_file(3) end";
        }
        {
          mode = "n";
          key = "<C-l>";
          action.__raw = "function() require('harpoon.ui').nav_file(4) end";
        }
      ];
    };
  };
}
