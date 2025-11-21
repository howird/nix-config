{
  config,
  pkgs,
  ...
}: {
  programs.opencode.enable = true;
  programs.opencode.settings = {
    mcp = {
      context7 = {
        enabled = true;
        type = "local";
        command = ["${pkgs.bun}/bin/bunx" "@upstash/context7-mcp"];
      };
    };
  };
}
