{pkgs, ...}: {
  programs.zed-editor = {
    installRemoteServer = true;
    mutableUserKeymaps = true;
    mutableUserDebug = true;
    extraPackages = with pkgs; [
      bun
      # claude-code-acp
      claude-code
      cursor-cli
    ];
  };

  programs.zed-editor.userSettings = {
    helix_mode = true;

    agent_servers = {
      claude-agent = {
        command = "bunx";
        args = ["@zed-industries/claude-code-acp"];
        env = {};
      };
      cursor-agent = {
        command = "bunx";
        args = ["@blowmage/cursor-agent-acp"];
        env = {};
      };
    };

    context_servers = {
      Context7 = {
        source = "custom";
        command = "bunx";
        args = ["@upstash/context7-mcp"];
      };
    };
  };
}
