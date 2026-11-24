{den, ...}: {
  den.aspects.howird.includes = [
    den.batteries.define-user
    den.batteries.primary-user
    # Use Zsh for macOS account shells; Nushell remains available in the home.
    ({host, user}:
      den.batteries.user-shell (
        if (host.class or null) == "darwin"
        then "zsh"
        else "nushell"
      ))
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

  den.aspects.howird.nixos.services.tailscale.extraSetFlags = ["--operator=howird"];
}
