{
  inputs,
  den,
  ...
}: {
  den.hosts.x86_64-linux.yerm = {
    users.howird = {};
    keymap = "framework";
    internalScale = 1.6;
    syncthing.id = "RBMEI57-GJNYWOV-QU5RHAX-HQSRD7Q-3SYCAG2-KVALZXA-5NP7VMA-V7N3ZA4";
  };

  den.aspects.yerm.includes = [
    den.aspects.roles.workstation
    den.aspects.roles.laptop
    den.aspects.paseo
    den.aspects.paseo-daemon
  ];

  den.aspects.yerm.nixos = {
    imports = [
      inputs.hardware.nixosModules.framework-13-7040-amd
      ./_hardware-configuration.nix
    ];

    # The noctalia lock screen checks passwords against the "login" PAM stack
    # while it reads the fingerprint sensor itself over D-Bus. With
    # pam_fprintd in that stack, a typed password first waits on a finger.
    # Workaround for noctalia-dev/noctalia#3277; once #4132 lands, point
    # lockscreen.pam_service at a dedicated stack and leave login alone.
    security.pam.services.login.fprintAuth = false;

    # services.kanata.keyboards.foldable.configFile = ../../../configs/keyboards/kanata/protoarc.kbd;
  };

  den.aspects.yerm.homeManager = {
    # fprintd itself comes from the nixos-hardware framework module
    programs.noctalia.settings.lockscreen.fingerprint = true;
  };
}
