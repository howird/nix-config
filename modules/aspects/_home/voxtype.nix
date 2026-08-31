{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.voxtype.homeManagerModules.default
  ];

  home.packages = with pkgs; [
    wtype
    voxtype-vulkan
  ];

  # programs.voxtype = {
  #   enable = true;
  #   package = pkgs.voxtype-vulkan;
  #     model.name = "base.en";
  #   service.enable = true;
  #     settings = {
  #       audio = {
  #         device = "default";
  #         sample_rate = 16000;
  #         max_duration_secs = 120;
  #       };
  #       hotkey.enabled = false;
  #       whisper.language = "en";
  #     };
  # };
}
