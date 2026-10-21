{den, ...}: {
  den.hosts.aarch64-darwin.mba = {
    users.howird = {};
    keymap = "macbook";
  };

  den.aspects.mba.includes = [
    den.aspects.gui
    den.aspects.homebrew
  ];

  den.aspects.mba.darwin = {
    networking.computerName = "mba";
    networking.localHostName = "mba";
  };
}
