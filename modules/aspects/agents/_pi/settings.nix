{pkgs, lib, ...}: {
  programs.pi-coding-agent.settings = {
    npmCommand = [(lib.getExe pkgs.bun)];
    enabledModels = [
      "openai/gpt-6.1-sol"
      "openai/gpt-6.1-terra"
      "claude-code/claude-opus-5-5"
      "claude-code/claude-sonnet-5-5"
      "anthropic/claude-opus-5-5"
      "anthropic/claude-sonnet-5-5"
    ];
  };
}
