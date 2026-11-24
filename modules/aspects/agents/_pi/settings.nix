{
  pkgs,
  lib,
  ...
}: {
  programs.pi-coding-agent.settings = {
    npmCommand = [(lib.getExe pkgs.bun)];
    defaultProvider = "openai";
    defaultModel = "gpt-6.2-sol";
    enabledModels = [
      "openai/gpt-6.2-astra"
      "openai/gpt-6.2-sol"
      "openai/gpt-6.1-terra"
      "claude-code/claude-opus-5-5"
      "claude-code/claude-sonnet-5-5"
      "claude-code/claude-fable-5-2"
      "anthropic/claude-opus-5-5"
      "anthropic/claude-sonnet-5-5"
    ];
  };
}
