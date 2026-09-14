{...}: {
  den.aspects.kiro.homeManager = {pkgs, ...}: {
    home.packages = with pkgs;
      [
        kiro-cli
      ]
      ++ (
        # for NixOS
        if pkgs.stdenv.hostPlatform.isLinux
        then [kiro-fhs]
        else [kiro]
      );
  };
}
