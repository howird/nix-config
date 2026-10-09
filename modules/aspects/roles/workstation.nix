{den, ...}: {
  # A machine someone sits in front of: sound, printing, a graphical session
  # and the desktop itself. The desktop bundle's homeManager halves reach the
  # host's users through den.batteries.host-aspects.
  den.aspects.roles.workstation.includes = [
    den.aspects.desktop
    den.aspects.graphics
    den.aspects.emulators
    den.aspects.input-devices
    den.aspects.mobile
    den.aspects.files
  ];

  den.aspects.roles.workstation.nixos = {
    services.printing.enable = true;

    services.xserver.enable = true;
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      audio.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    services.flatpak.enable = true;

    virtualisation.docker.enable = true;
  };
}
