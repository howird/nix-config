{
  # pkgs,
  config,
  ...
}: {
  imports = [
    # inputs.stylix.homeModules.stylix
    # ./stylix.nix
    ./desktops/gnome/dconf.nix
  ];

  myShell.aliases.nixwird = "home-manager switch --flake /home/${config.myUsername}/nix/config${config.myShell.hmFlakeArgs}";
  # home.packages = with pkgs.nixgl; [
  #   auto.nixGLDefault
  #   nixGLNvidia
  # ];
}
