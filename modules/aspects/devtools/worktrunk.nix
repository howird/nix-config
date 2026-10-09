{
  den.aspects.worktrunk.homeManager = {config, ...}: {
    programs.worktrunk = {
      enable = true;
      # statusline, worktree-isolation and activity hooks, and skills
      claudeCodeIntegration = {
        enable = config.programs.claude-code.enable;
        # config.toml is left to wt (no `settings`), so the skill can edit it
        configurationSkill = true;
      };
    };

    # /wt-switch-create re-roots the session with claude's EnterWorktree tool
    programs.pi.coding-agent.excludedClaudeSkills = ["wt-switch-create"];
  };
}
