{den, ...}: {
  den.aspects.howird.includes = [
    den.batteries.define-user
    den.batteries.primary-user
    (den.batteries.user-shell "nushell")
    den.batteries.host-aspects

    # zellij's tab bar reads stylix colors, so this user needs stylix even
    # on a host without gui.
    den.aspects.stylix

    den.aspects.shell
    den.aspects.editors
    den.aspects.agents
    den.aspects.devtools
    den.aspects.typesetting
  ];

  den.aspects.howird.nixos.users.users.howird = {
    description = "Howard Nguyen-Huu";
    extraGroups = ["docker" "audio" "video" "render" "kvm" "adbusers"];
  };
}
