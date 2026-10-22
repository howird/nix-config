{inputs, ...}: {
  den.aspects.zotero.homeManager = {
    pkgs,
    lib,
    ...
  }: let
    stable = inputs.nixpkgs-stable.legacyPackages.${pkgs.stdenv.hostPlatform.system};

    # reads zotero.sqlite directly; needs zotero's "Allow other applications on
    # this computer to communicate with Zotero" (settings -> advanced). writes
    # need a one-time `zotero-mcp authorize-local` (zotero 10+)
    zotero-mcp = {
      command = lib.getExe' pkgs.uv "uvx";
      args = ["--from" "zotero-mcp-server==0.13.3" "zotero-mcp" "serve"];
      env.ZOTERO_LOCAL = "true";
    };
  in {
    myMcp.servers.zotero = zotero-mcp;

    home.packages = with pkgs; [
      # zotero 10 targets gecko 140 (app/config.sh GECKO_VERSION_LINUX), but
      # unstable dropped esr 140 and builds it on esr 153, which breaks
      # fetch_xulrunner's ActorManagerParent edits. Feed it stable's esr 140.
      (zotero.override {firefox-esr-153-unwrapped = stable.firefox-esr-140-unwrapped;})
    ];
  };
}
