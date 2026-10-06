{...}: let
  # asana has no dynamic client registration; mcp-remote handles the
  # pre-registered oauth app (untracked {client_id, client_secret} json)
  asana = {
    pkgs,
    lib,
  }: rec {
    clientInfo = home: "${home}/.config/mcp/asana-oauth-client.json";
    command = lib.getExe' pkgs.bun "bunx";
    baseArgs = [
      "mcp-remote@0.14.3"
      "https://mcp.asana.com/v2/mcp"
      "8080"
      "--callback-path"
      "/callback"
    ];
    server = home: {
      inherit command;
      args = baseArgs ++ ["--static-oauth-client-info" "@${clientInfo home}"];
    };

    # one-time sign-in (same args as the server, so the token in ~/.mcp-auth is shared);
    # writes the client info file first if this machine doesn't have it yet
    login = pkgs.writeShellApplication {
      name = "asana-login";
      runtimeInputs = [pkgs.jq];
      text = ''
        info="${clientInfo "$HOME"}"
        if [ ! -f "$info" ]; then
          echo "No Asana OAuth client info at $info" >&2
          echo "Find these under your app's OAuth settings in Asana's developer console" >&2
          read -rp "Client ID: " id
          read -rsp "Client secret: " secret
          echo >&2
          if [ -z "$id" ] || [ -z "$secret" ]; then
            echo "Client ID and secret are both required, aborting" >&2
            exit 1
          fi
          mkdir -p "$(dirname "$info")"
          (
            umask 077
            jq -n --arg id "$id" --arg secret "$secret" \
              '{client_id: $id, client_secret: $secret}' >"$info"
          )
          echo "Wrote $info" >&2
        fi
        exec ${lib.escapeShellArgs ([command] ++ baseArgs)} --static-oauth-client-info "@$info" "$@"
      '';
    };
  };
in {
  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    packages.asana-login = (asana {inherit pkgs lib;}).login;
  };

  den.aspects.mcp.homeManager = {
    config,
    pkgs,
    lib,
    ...
  }: let
    servers = {
      linear.url = "https://mcp.linear.app/mcp";
      asana = (asana {inherit pkgs lib;}).server config.home.homeDirectory;
    };
  in {
    programs.claude-code.mcpServers = servers;
    programs.pi.coding-agent.mcp.mcpServers = servers;
  };
}
