{den, ...}: {
  den.aspects.subagents.homeManager = {
    home.file = {
      ".pi/agent/agents/scout.md".source = ./subagents/scout.md;
      ".pi/agent/agents/worker.md".source = ./subagents/worker.md;
      ".pi/agent/agents/reviewer.md".source = ./subagents/reviewer.md;
      ".pi/agent/agents/oracle.md".source = ./subagents/oracle.md;
      ".pi/agent/agents/tutor.md".source = ./subagents/tutor.md;
    };
  };
}
