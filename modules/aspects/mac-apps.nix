{...}: {
  den.aspects.mac-apps.homeManager = {pkgs, ...}: {
    # when possible use nixpkgs else use brew casks
    home.packages = with pkgs; [
      linear
      slack
    ];
  };
}
