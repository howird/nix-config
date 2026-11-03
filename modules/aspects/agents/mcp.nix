{
  # Servers are declared in `myMcp.servers` (see defaults.nix); the zotero one
  # lives with zotero itself, in apps/zotero.nix.
  den.aspects.mcp.homeManager = {
    lib,
    pkgs,
    config,
    ...
  }: let
    servers =
      lib.mapAttrs (_: s: removeAttrs s ["enable"])
      (lib.filterAttrs (_: s: s.enable) config.myMcp.servers);
    piDir = config.programs.pi-coding-agent.configDir;
  in {
    myMcp.servers = {
      linear.url = "https://mcp.linear.app/mcp";
      plane.url = "https://mcp.plane.so/http/mcp";
    };

    programs.claude-code.mcpServers = servers;
    # The Home Manager pi-coding-agent module has no MCP option, so merge our
    # servers into pi's mcp.json the same way it merges settings.json:
    # declared values win, unmanaged entries are kept.
    home.activation.piCodingAgentMcp = lib.hm.dag.entryAfter ["linkGeneration"] (
      lib.hm.generators.mkImpureConfigMerger {
        inherit pkgs;
        format = "json";
        empty = "{}";
        mode = "600";
        path = "${piDir}/mcp.json";
        staticSettings = (pkgs.formats.json {}).generate "pi-mcp.json" {mcpServers = servers;};
        jqOperation = "$dynamic * $static";
      }
    );
  };
}
