{
  # Servers are declared in `myMcp.servers` (see defaults.nix); the zotero one
  # lives with zotero itself, in apps/zotero.nix.
  den.aspects.mcp.homeManager = {
    lib,
    config,
    ...
  }: let
    servers =
      lib.mapAttrs (_: s: removeAttrs s ["enable"])
      (lib.filterAttrs (_: s: s.enable) config.myMcp.servers);
  in {
    myMcp.servers = {
      linear.url = "https://mcp.linear.app/mcp";
      plane.url = "https://mcp.plane.so/http/mcp";
    };

    programs.claude-code.mcpServers = servers;
    programs.pi.coding-agent.mcp.mcpServers = servers;
  };
}
