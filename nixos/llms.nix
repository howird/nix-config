{
  lib,
  config,
  pkgs,
  ...
}: {
  services = {
    ollama = {
      package =
        if config.myGraphics.amd
        then pkgs.ollama-rocm
        else pkgs.ollama-cuda;
      acceleration =
        if config.myGraphics.amd
        then "rocm"
        else "cuda";
      rocmOverrideGfx = lib.mkIf config.myGraphics.amd "11.0.0";
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
}
