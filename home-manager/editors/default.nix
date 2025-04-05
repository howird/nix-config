{lib, ...}: {
  imports = [
    ./vscode
    # ./nixvim
    ./nvf
    ./zed
    ./helix
  ];

  options = {
    myEditor = {
      vscode = lib.mkEnableOption "vscode";
      vscodium = lib.mkEnableOption "vscodium";
      nvim = lib.mkEnableOption "nvim";
      zed = lib.mkEnableOption "zed";
      helix = lib.mkEnableOption "helix";
    };
  };
}
