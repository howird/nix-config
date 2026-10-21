{
  # The zotero server lives with zotero itself, in apps/zotero.nix.
  den.aspects.mcp.homeManager = let
    servers = {
      linear.url = "https://mcp.linear.app/mcp";
      plane.url = "https://mcp.plane.so/http/mcp";
    };
  in {
    programs.claude-code.mcpServers = servers;
    programs.pi.coding-agent.mcp.mcpServers = servers;
  };
}
