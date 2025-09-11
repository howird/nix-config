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
      "uda.taskwarrior-tui.shortcuts.1" = "";

      "urgency.annotations.coefficient" = 0;
      "urgency.tags.coefficient" = 0;
      "urgency.project.coefficient" = 0;

      "uda.effort.type" = "string";
      "uda.effort.label" = "Effort";
      "uda.effort.values" = "s,m,l,xl,xxl";
      "urgency.uda.effort.s.coefficient" = 1.5;
      "urgency.uda.effort.m.coefficient" = 1.1;
      "urgency.uda.effort.l.coefficient" = 1;
      "urgency.uda.effort.xl.coefficient" = 0;
      "urgency.uda.effort.xxl.coefficient" = -0.2;
      "color.uda.effort.s" = "color180";
      "color.uda.effort.m" = "color210";
      "color.uda.effort.l" = "color255";
      "color.uda.effort.xl" = "color255";
      "color.uda.effort.xxl" = "color255";
    };
  };
  home.packages = with pkgs; [
    timewarrior
    taskwarrior-tui
  ];
}
