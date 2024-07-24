{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  services.kanata.enable = true;
  services.kanata.keyboards.keebwird = {
    configFile = ./configs/qwerty.kbd;
  };
}
