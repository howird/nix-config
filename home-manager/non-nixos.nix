{config, ...}: {
  imports = [
    # inputs.stylix.homeModules.stylix
    ./stylix.nix
    ./desktops/gnome/dconf.nix
  ];

  myShell.aliases.nixwird = "home-manager switch --flake /home/${config.home.username}/nix/config${config.myShell.hmFlakeArgs}";
  stylix.autoEnable = false;
  stylix.targets.nvf.enable = true;
  stylix.targets.zellij.enable = true;
  stylix.targets.gnome.enable = true;
  stylix.targets.gtk.enable = true;

  # home.packages = with pkgs.nixgl; [
  #   auto.nixGLDefault
  #   nixGLNvidia
  # ];
}
