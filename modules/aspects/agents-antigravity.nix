{...}: {
  den.aspects.agents-antigravity.homeManager = {pkgs, ...}: {
    home.packages = [pkgs.antigravity-cli];
  };
}
