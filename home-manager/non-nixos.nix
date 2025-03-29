{config, ...}: {
  myShell.aliases.nixwird = "home-manager switch --flake /home/${config.myUsername}/nix/config${config.myShell.hmFlakeArgs}";
}
