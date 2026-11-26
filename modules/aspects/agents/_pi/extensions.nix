{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  piSubagents = pkgs.applyPatches {
    name = "pi-subagents-2.9.2-background-runner";
    src = pkgs.fetchFromGitHub {
      owner = "edxeth";
      repo = "pi-subagents";
      rev = "cf6dbf41c17986f3882e6804a68e8fb8282d25e6";
      hash = "sha256-Z95FzKiENUM8BsmkW3uiBNY97/+DTCaa94wA2XCAMcI=";
    };
    patches = [./pi-subagents-background-runner.patch];
  };

  packages = [
    "git:github.com/earendil-works/pi-claude-code"
    "${piSubagents}"
    "${./claude-review}"
    "npm:@plannotator/pi-extension"
    "${inputs.pi-helix.packages.${pkgs.stdenv.hostPlatform.system}.default}"
  ];

  # Sources that used to be declared here. mutableSettings never removes
  # undeclared entries, so list retired ones to drop them on activation.
  retiredPackages = [
    "git:github.com/edxeth/pi-subagents"
  ];
in {
  programs.pi-coding-agent.settings.packages = packages;

  # Runs before Home Manager's settings merge. Drops retired sources and any
  # /nix/store package that is no longer declared (old generations' paths);
  # entries added with `pi install` are kept.
  home.activation.piCodingAgentPrunePackages =
    lib.hm.dag.entryBetween ["piCodingAgentMutableSettings"] ["linkGeneration"] ''
      settings=${lib.escapeShellArg "${config.programs.pi-coding-agent.configDir}/settings.json"}
      if [[ -f "$settings" ]]; then
        tmp="$(mktemp "$settings.XXXXXX")"
        if ${lib.getExe pkgs.jq} \
          --argjson declared ${lib.escapeShellArg (builtins.toJSON packages)} \
          --argjson retired ${lib.escapeShellArg (builtins.toJSON retiredPackages)} '
            def src: if type == "object" then .source else . end;
            if has("packages") then
              .packages |= map(select(
                (src) as $s
                | ($s | IN($retired[]) | not)
                  and (($s | startswith("/nix/store/") | not) or ($s | IN($declared[])))
              ))
            else . end
          ' "$settings" > "$tmp"; then
          chmod 600 "$tmp"
          run mv "$tmp" "$settings"
        else
          rm -f "$tmp"
          errorEcho "Failed to prune pi packages in $settings"
          exit 1
        fi
      fi
    '';
}
