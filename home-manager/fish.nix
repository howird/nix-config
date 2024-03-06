{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    grc
  ];

  programs.fish = {
    enable = true;
    package = pkgs.fish;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    shellAliases = {
      ll = "ls -l";
      vim = "lvim";
      nixwird = "sudo nixos-rebuild switch --flake /home/howird/.config/nix";
      nixwird-hm = "home-manager switch --flake /home/howird/.config/nix";
    };
    plugins = [
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
      /*
      tide configure --auto --style=Rainbow --prompt_colors='True color' \
      --show_time='12-hour format' --rainbow_prompt_separators=Vertical \
      --powerline_prompt_heads=Sharp --powerline_prompt_tails=Sharp \
      --powerline_prompt_style='Two lines, character' \
      --prompt_connection=Dotted --powerline_right_prompt_frame=No \
      --prompt_connection_andor_frame_color=Light --prompt_spacing=Sparse \
      --icons='Many icons' --transient=Yes
      */
      { name = "tide"; src = pkgs.fishPlugins.tide.src; }
      { name = "bass"; src = pkgs.fishPlugins.bass.src; }
      { name = "pisces"; src = pkgs.fishPlugins.pisces.src; }
      { name = "fzf-fish"; src = pkgs.fishPlugins.fzf-fish.src; }
    ];
  };
}
