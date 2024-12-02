{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "Howard Nguyen-Huu";
    userEmail = config.myEmail;
    aliases = {
      ci = "commit";
      co = "checkout";
      s = "status";
    };
    ignores = [
      "**/.aider*"
    ];
  };
}
