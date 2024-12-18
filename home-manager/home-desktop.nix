{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./modules/desktops
    ./modules/editors
    ./modules/shells
    ./modules/browsers

    ./modules/alacritty.nix
    ./modules/packages.nix
  ];

  config = {
    # desktops
    myDesktop.kde = true;
    myDesktop.kdeTheme = "reactionary";
    myCursor.theme = "Posy_Cursor";

    # editors
    myEditor.vscode = true;
    myEditor.zed = true;

    # shells
    myShell.zsh = true;

    # browsers
    myBrowser.edge = true;
    myBrowser.zen = true;
  };
}
