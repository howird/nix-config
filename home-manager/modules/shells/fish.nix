{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf config.myShell.fish {
  home.packages = with pkgs; [
    grc
  ];

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting

      # commented out since i'm not sure if this should run every init
      : '
      tide configure --auto --style=Rainbow --prompt_colors='True color' \
        --show_time='12-hour format' --rainbow_prompt_separators=Vertical \
        --powerline_prompt_heads=Sharp --powerline_prompt_tails=Sharp \
        --powerline_prompt_style='Two lines, character' \
        --prompt_connection=Dotted --powerline_right_prompt_frame=No \
        --prompt_connection_andor_frame_color=Light --prompt_spacing=Sparse \
        --icons='Many icons' --transient=Yes
      '
    '';
    shellAliases = config.myShell.aliases;
    plugins = [
      {
        name = "grc";
        src = pkgs.fishPlugins.grc.src;
      }
      {
        name = "tide";
        src = pkgs.fishPlugins.tide.src;
      }
      {
        name = "bass";
        src = pkgs.fishPlugins.bass.src;
      }
      {
        name = "pisces";
        src = pkgs.fishPlugins.pisces.src;
      }
      {
        name = "fzf-fish";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
    ];
  };
}
