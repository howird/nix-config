{
  pkgs,
  lib,
  ...
}: {
  programs.helix.settings = {
    editor = {
      cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "underline";
      };
      line-number = "relative";
      mouse = true;
      rulers = [120];
      true-color = true;
      completion-replace = true;
      trim-trailing-whitespace = true;
      end-of-line-diagnostics = "hint";
      color-modes = true;

      inline-diagnostics.cursor-line = "warning";
      file-picker.hidden = false;

      indent-guides = {
        render = true;
        character = "╎";
        skip-levels = 0;
      };
      soft-wrap.enable = false;

      auto-save = {
        focus-lost = true;
        after-delay.enable = true;
        after-delay.timeout = 300000;
      };
    };
  };
  # see https://rushter.com/blog/helix-editor/
  # https://github.com/sxyazi/yazi/pull/2461

  programs.helix.settings.theme = lib.mkDefault "everforest_dark_no_bg";
  xdg.configFile."helix/themes/everforest_dark_no_bg.toml".text = ''
    inherits = "everforest_dark"
    "ui.background" = {}
  '';

  home.packages = with pkgs; [
    rustfmt
    pyright
    yazi
  ];
}
