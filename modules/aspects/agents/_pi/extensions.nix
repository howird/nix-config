{
  inputs,
  pkgs,
  ...
}: {
  programs.pi-coding-agent.settings.packages = [
    "git:github.com/earendil-works/pi-claude-code"
    "git:github.com/edxeth/pi-subagents"
    "npm:@plannotator/pi-extension"
    "${inputs.pi-helix.packages.${pkgs.stdenv.hostPlatform.system}.default}"
  ];
}
