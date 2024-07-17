{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../home.nix
  ];

  config = {
    myUsername = "howard";
    myEmail = "howard.nguyen-huu@uwaterloo.ca";
  };
}
