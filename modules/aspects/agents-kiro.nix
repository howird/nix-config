{...}: {
  den.aspects.agents-kiro.homeManager = {pkgs, ...}: {
    home.packages = with pkgs; [
      kiro-fhs
      kiro-cli
    ];
  };
}
