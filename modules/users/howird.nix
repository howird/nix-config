{den, ...}: {
  den.aspects.howird.includes = [
    den.batteries.define-user
    den.batteries.primary-user
    (den.batteries.user-shell "zsh")
    den.batteries.host-aspects

    den.aspects.bundles.shell
    den.aspects.bundles.editors
    den.aspects.bundles.agents
    den.aspects.bundles.devtools
    den.aspects.bundles.docs
    den.aspects.bundles.personal
  ];

  den.aspects.howird.nixos.users.users.howird = {
    description = "Howard Nguyen-Huu";
    extraGroups = ["docker" "audio" "video" "render" "kvm" "adbusers"];
  };
}
