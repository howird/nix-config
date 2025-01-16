{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  config = {
    programs.helix = {
      enable = true;
    };
  };
}
