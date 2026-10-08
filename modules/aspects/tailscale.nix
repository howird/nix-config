{...}: {
  den.aspects.tailscale.nixos = {
    services.tailscale = {
      enable = true;
      extraSetFlags = ["--ssh"];
    };

    networking.firewall.trustedInterfaces = ["tailscale0"];
  };

  den.aspects.tailscale.darwin = {
    services.tailscale.enable = true;
  };

  # Unprivileged tailscaled for machines we don't have root on (howard@vip,
  # which is several servers). Userspace networking needs no TUN device;
  # inbound tailnet connections are forwarded to localhost, so each server's
  # existing sshd answers on its tailnet IP. Each server joins under its own
  # system hostname (`ssh howard@<server>`).
  #
  # One-time setup, per server:
  #   1. `loginctl enable-linger` so the service outlives logout (if
  #      disallowed, it only runs while logged in)
  #   2. `tailscale up` (the alias below points at this daemon's socket) and
  #      log in
  den.aspects.tailscale-userspace.homeManager = {
    config,
    lib,
    pkgs,
    ...
  }: let
    stateDir = "${config.xdg.stateHome}/tailscale";
    socket = "${stateDir}/tailscaled.sock";
  in {
    home.packages = [pkgs.tailscale];

    myShell.aliases.tailscale = "tailscale --socket=${socket}";

    systemd.user.services.tailscaled = {
      Unit.Description = "Tailscale (userspace networking)";
      Service = {
        ExecStart = lib.escapeShellArgs [
          (lib.getExe' pkgs.tailscale "tailscaled")
          "--tun=userspace-networking"
          "--statedir=${stateDir}"
          "--socket=${socket}"
          "--port=0"
        ];
        Restart = "on-failure";
      };
      Install.WantedBy = ["default.target"];
    };
  };
}
