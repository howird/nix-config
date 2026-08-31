{...}: {
  # Not included by any host today except bofa (matches the pre-migration
  # repo, where nixos/llms.nix was only ever imported by hosts/bofa).
  den.aspects.llms.nixos = {
    host,
    lib,
    config,
    pkgs,
    ...
  }: {
    services = {
      ollama = {
        package =
          if host.gpu == "amd"
          then pkgs.ollama-rocm
          else pkgs.ollama-cuda;
        rocmOverrideGfx = lib.mkIf (host.gpu == "amd") "11.0.0";
      };
      open-webui = {
        environment = {
          OLLAMA_API_BASE_URL = lib.mkIf config.services.ollama.enable "http://127.0.0.1:11434";
          WEBUI_AUTH = "False";
          ANONYMIZED_TELEMETRY = "False";
          DO_NOT_TRACK = "True";
          SCARF_NO_ANALYTICS = "True";
        };
      };
    };
  };
}
