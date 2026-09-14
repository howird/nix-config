{...}: {
  den.aspects.mcp.homeManager = {
    programs.mcp = {
      enable = true;
      servers.linear.url = "https://mcp.linear.app/mcp";
    };
  };
}
