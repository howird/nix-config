{
  den.aspects.zotero.nixos = {
    nixpkgs.config.permittedInsecurePackages = [
      "firefox-esr-140-bin-unwrapped-140.17.0esr" # TODO(howird): drop when fixed
    ];
  };

  den.aspects.zotero.homeManager = {
    pkgs,
    lib,
    ...
  }: let
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

    home.packages = [pkgs.zotero];
  };
}
