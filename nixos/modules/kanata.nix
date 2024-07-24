{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  services.kanata.enable = true;
  services.kanata.keyboards.framework = {
    configFile = ./configs/kanata.kbd;
  };
}
