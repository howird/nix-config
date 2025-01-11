{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  host,
  ...
}: {
  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true";
  services.syncthing = let
    devices = builtins.filter (e: e != host) ["yerm" "boox"];
  in {
    openDefaultPorts = true;
    user = "howird";
    dataDir = "/home/howird";
    configDir = "/home/howird/.config/syncthing";
    settings = {
      devices = lib.attrsets.filterAttrs (n: v: n != host) {
        yerm.id = "RBMEI57-GJNYWOV-QU5RHAX-HQSRD7Q-3SYCAG2-KVALZXA-5NP7VMA-V7N3ZA4";
        boox.id = "PG2L5EP-JYRYMEA-BYYD6TY-ZMVDBCC-2I2WHDJ-HZEF3EK-5TZPYHC-DO3QYQB";
      };
      folders = {
        Papers = {
          inherit devices;
          id = "5v9ze-qjxem";
          path = "/home/howird/docs/papers";
          ignorePerms = true;
        };
        Books = {
          inherit devices;
          id = "aaqo7-hfgmf";
          path = "/home/howird/docs/Books";
          ignorePerms = true;
        };
        ToSign = {
          inherit devices;
          id = "kh2vs-k39ht";
          path = "/home/howird/docs/ToSign";
          ignorePerms = true;
        };
      };
    };
  };
}
