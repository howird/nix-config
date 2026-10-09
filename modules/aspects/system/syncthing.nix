{
  den,
  lib,
  ...
}: let
  # Every declared host with a syncthing id is a peer of every other one.
  hostIds = lib.concatMapAttrs (_: hosts:
    lib.mapAttrs (_: h: h.syncthing.id)
    (lib.filterAttrs (_: h: h.syncthing.id != null) hosts))
  den.hosts;
in {
  # User-owned: it syncs this user's folders, as this user. Active on any
  # host that declares `syncthing.id`.
  den.aspects.syncthing.includes = [
    ({
      host,
      user,
    }: {
      nixos = {config, ...}:
        lib.mkIf (host.syncthing.id != null) (let
          hostName = host.name;
          user' = user.userName;
          home = config.users.users.${user'}.home;
        in {
          systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true";
          services.syncthing = let
            devices = builtins.filter (e: e != hostName) (lib.attrNames hostIds ++ ["boox" "supernote"]);
          in {
            enable = true;
            openDefaultPorts = true;
            user = user';
            dataDir = home;
            configDir = "${home}/.config/syncthing";
            settings = {
              devices = lib.attrsets.filterAttrs (n: v: n != hostName) (lib.mapAttrs (_: id: {inherit id;}) hostIds
                // {
                  boox.id = "PG2L5EP-JYRYMEA-BYYD6TY-ZMVDBCC-2I2WHDJ-HZEF3EK-5TZPYHC-DO3QYQB";
                  supernote.id = "F4DFNGP-CSY3MSB-TZHLP33-2FN74KG-DRWCWPC-TF5VBZT-Q27MKJO-PXMWIQX";
                  BeepBoopBop.id = "DRIKCSN-H2LHQTR-Y5O3XHU-YFPPMX5-QDEUA6I-GARRQ52-DUHA4ZE-AV532QK";
                });
              folders = {
                Papers = {
                  inherit devices;
                  id = "5v9ze-qjxem";
                  path = "${home}/papers";
                  ignorePerms = true;
                };
                SuperNotes = {
                  inherit devices;
                  id = "vhkwt-suv6b";
                  path = "${home}/supernotes";
                  ignorePerms = true;
                };
                Notes = {
                  inherit devices;
                  id = "h3cfv-d6qmg";
                  path = "${home}/notes";
                  ignorePerms = true;
                };
                ReadingList = {
                  inherit devices;
                  id = "ssrpx-u4pwm";
                  path = "${home}/readinglist";
                  ignorePerms = true;
                };
                Books = {
                  inherit devices;
                  id = "aaqo7-hfgmf";
                  path = "${home}/books";
                  ignorePerms = true;
                };
                ToSign = {
                  inherit devices;
                  id = "kh2vs-k39ht";
                  path = "${home}/tosign";
                  ignorePerms = true;
                };
              };
            };
          };
        });
    })
  ];
}
