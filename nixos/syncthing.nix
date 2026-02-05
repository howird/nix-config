{
  lib,
  host,
  ...
}: {
  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true";
  services.syncthing = let
    devices = builtins.filter (e: e != host) ["yerm" "bofa" "boox" "supernote"];
  in {
    openDefaultPorts = true;
    user = "howird";
    dataDir = "/home/howird";
    configDir = "/home/howird/.config/syncthing";
    settings = {
      devices = lib.attrsets.filterAttrs (n: v: n != host) {
        yerm.id = "RBMEI57-GJNYWOV-QU5RHAX-HQSRD7Q-3SYCAG2-KVALZXA-5NP7VMA-V7N3ZA4";
        bofa.id = "BP3NP5F-OHLLWR3-RY5NCR4-ADNXU3O-6J3TSBF-XZAIBF6-A3UVGKG-AQXHMQ4";
        boox.id = "PG2L5EP-JYRYMEA-BYYD6TY-ZMVDBCC-2I2WHDJ-HZEF3EK-5TZPYHC-DO3QYQB";
        supernote.id = "F4DFNGP-CSY3MSB-TZHLP33-2FN74KG-DRWCWPC-TF5VBZT-Q27MKJO-PXMWIQX";
        BeepBoopBop.id = "DRIKCSN-H2LHQTR-Y5O3XHU-YFPPMX5-QDEUA6I-GARRQ52-DUHA4ZE-AV532QK";
      };
      folders = {
        Papers = {
          inherit devices;
          id = "5v9ze-qjxem";
          path = "/home/howird/papers";
          ignorePerms = true;
        };
        SuperNotes = {
          inherit devices;
          id = "vhkwt-suv6b";
          path = "/home/howird/supernotes";
          ignorePerms = true;
        };
        Notes = {
          inherit devices;
          id = "h3cfv-d6qmg";
          path = "/home/howird/notes";
          ignorePerms = true;
        };
        ReadingList = {
          inherit devices;
          id = "ssrpx-u4pwm";
          path = "/home/howird/readinglist";
          ignorePerms = true;
        };
        Books = {
          inherit devices;
          id = "aaqo7-hfgmf";
          path = "/home/howird/books";
          ignorePerms = true;
        };
        ToSign = {
          inherit devices;
          id = "kh2vs-k39ht";
          path = "/home/howird/tosign";
          ignorePerms = true;
        };
      };
    };
  };
}
