{...}: {
  programs.nvf.settings.vim = {
    notes.obsidian = {
      enable = true;
      setupOpts = {
        workspaces = [
          {
            name = "scivolt";
            path = "~/scivolt";
          }
        ];
        notes_subdir = "2_concepts";
        new_notes_location = "notes_subdir";
        completion = {
          nvim_cmp = true;
          min_chars = 2;
        };
      };
    };
    keymaps = [
    ];
  };
}
