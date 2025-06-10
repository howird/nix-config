{lib, ...}: {
  imports = [
    ./base-keymaps.nix
    ./debug.nix
    ./git.nix
    ./harpoon.nix
    ./languages.nix
    ./lsp.nix
    # ./notes.nix
    ./oil.nix
    ./telescope.nix
  ];

  programs.nvf.settings.vim = {
    viAlias = true;
    vimAlias = true;

    statusline.lualine.enable = true;
    comments.comment-nvim.enable = true;
    session.nvim-session-manager.enable = true;

    mini = {
      ai.enable = true;
      surround.enable = true;
      operators.enable = true;
      pairs.enable = true;
      bracketed.enable = true;
      comment.enable = true;
      diff.enable = true;
      indentscope.enable = true;
    };

    theme = {
      enable = true;
      transparent = lib.mkForce true;
    };

    visuals = {
      nvim-web-devicons.enable = true;
      nvim-cursorline.enable = true;
      cinnamon-nvim.enable = true;
      fidget-nvim.enable = true;

      highlight-undo.enable = true;
      indent-blankline.enable = true;
    };

    ui = {
      colorizer.enable = true;
      borders.enable = true;
      noice.enable = true;
    };

    notes = {
      todo-comments.enable = true;
    };

    utility = {
      sleuth.enable = true;
      multicursors.enable = true;
      diffview-nvim.enable = true;
      images.image-nvim.enable = false;
      motion = {
        hop.enable = true;
        leap.enable = true;
      };
    };

    binds = {
      whichKey.enable = true;
      cheatsheet.enable = true;
    };

    dashboard.alpha.enable = true;
  };
}
