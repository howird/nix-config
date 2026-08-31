{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    grc
  ];

  programs.fish = {
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    shellAliases = config.myShell.aliases;
    plugins = [
      {
        name = "grc";
        src = pkgs.fishPlugins.grc.src;
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
