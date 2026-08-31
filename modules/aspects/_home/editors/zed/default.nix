{pkgs, ...}: {
  programs.zed-editor = {
    installRemoteServer = true;
    mutableUserKeymaps = true;
    mutableUserDebug = true;
    extraPackages = with pkgs; [
      bun
      # claude-code
      # aider-chat
      # fabric-ai
      # cursor-cli
    ];
  };

  # programs.zed-editor.userSettings = {
  #   helix_mode = true;

  #   agent_servers = {
  #     # claude-agent = {
  #     #   command = "bunx";
  #     #   args = ["@zed-industries/claude-code-acp"];
  #     #   env = {};
  #     # };
  #     cursor-agent = {
  #       command = "agent";
  #       args = ["acp"];
  #       env = {};
  #     };
  #   };

  #   context_servers = {
  #     Context7 = {
  #       source = "custom";
  #       command = "bunx";
  #       args = ["@upstash/context7-mcp"];
  #     };
  #   };
  # };
}
