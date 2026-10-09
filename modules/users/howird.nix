{den, ...}: {
  den.aspects.howird.includes = [
    den.batteries.define-user
    den.batteries.primary-user
    (den.batteries.user-shell "zsh")
    den.batteries.host-aspects

    den.aspects.shell
    den.aspects.editors
    den.aspects.agents
    den.aspects.devtools
    den.aspects.docs

    den.aspects.rclone
    den.aspects.syncthing
  ];

  den.aspects.howird.nixos.users.users.howird = {
    description = "Howard Nguyen-Huu";
    extraGroups = ["docker" "audio" "video" "render" "kvm" "adbusers"];
  };
}
