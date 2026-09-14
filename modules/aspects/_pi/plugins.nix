{...}: {
  programs.pi-coding-agent.settings.packages = [
    "git:github.com/nicobailon/pi-mcp-adapter"
    "git:github.com/nicobailon/pi-subagents"
  ];
}
