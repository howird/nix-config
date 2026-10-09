{
  den.aspects.reading.homeManager = {pkgs, ...}: {
    home.packages = import ./_available.nix pkgs (with pkgs; [
      foliate
      percollate
      wordbook
      wike
    ]);
  };
}
