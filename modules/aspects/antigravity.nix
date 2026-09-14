{...}: {
  den.aspects.antigravity.homeManager = {pkgs, ...}: {
    home.packages = [pkgs.antigravity-cli];
  };
}
