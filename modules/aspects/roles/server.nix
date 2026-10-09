{
  # Reachable over the network: key-only ssh.
  den.aspects.roles.server.nixos = {
    services.openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
        X11Forwarding = true;
      };
    };
  };
}
