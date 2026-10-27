let
  # one list for every host; packages that don't build on the platform drop out
  packages = pkgs:
    import ../apps/_available.nix pkgs (with pkgs; [
      home-manager
      git
      zellij
      wget
      python3
      ouch # compression
      unrar
      ffmpeg-headless
      imagemagick
    ]);
in {
  den.aspects.system-packages.nixos = {pkgs, ...}: {
    # List packages installed in system profile. To search, run: `nix search wget`
    environment.systemPackages =
      packages pkgs
      ++ (with pkgs; [
        # hardware and system inspection
        busybox
        pciutils
        lshw
        dmidecode
        # macOS ships its own
        lsof
        xhost
      ]);

    programs = {
      git.enable = true;
      tmux.enable = true;
      zsh.enable = true;
    };
  };

  den.aspects.system-packages.darwin = {pkgs, ...}: {
    environment.systemPackages = packages pkgs;
  };
}
