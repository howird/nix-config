{den, ...}: {
  den.hosts.aarch64-darwin.sticker-mac-mini.users.howird = {};

  den.aspects.sticker-mac-mini.includes = [
    den.aspects.paseo-daemon
  ];

  den.aspects.sticker-mac-mini.darwin = {
    networking.computerName = "sticker-mac-mini";
    networking.localHostName = "sticker-mac-mini";
  };
}
