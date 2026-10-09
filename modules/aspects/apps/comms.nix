{
  den.aspects.comms.homeManager = {pkgs, ...}: {
    home.packages = import ./_available.nix pkgs (with pkgs; [
      vesktop
      slack
      signal-desktop
    ]);
  };
}
