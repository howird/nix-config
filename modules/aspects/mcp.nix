{
  den.aspects.mcp.homeManager = {
    pkgs,
    lib,
    ...
  }: let
    servers = {
      linear.url = "https://mcp.linear.app/mcp";
      plane.url = "https://mcp.plane.so/http/mcp";

      # reads zotero.sqlite directly; needs zotero's "Allow other applications on
      # this computer to communicate with Zotero" (settings -> advanced). writes
      # need a one-time `zotero-mcp authorize-local` (zotero 10+)
      zotero = {
        command = lib.getExe' pkgs.uv "uvx";
        args = ["--from" "zotero-mcp-server==0.13.3" "zotero-mcp" "serve"];
        env.ZOTERO_LOCAL = "true";
      };
    };
  in {
    programs.claude-code.mcpServers = servers;
    programs.pi.coding-agent.mcp.mcpServers = servers;
  };
}
