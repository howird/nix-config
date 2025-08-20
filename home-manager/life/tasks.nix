{pkgs, ...}: {
  myShell.aliases = {
    tu = "taskwarrior-tui";
    ta = "task";
    ti = "timew";
  };
  programs.taskwarrior = {
    enable = true;
    package = pkgs.taskwarrior3;
    config = {
      "uda.taskwarrior-tui.keyconfig.zoom" = "=";
    };
  };
  home.packages = with pkgs; [
    timewarrior
    taskwarrior-tui
  ];
}
