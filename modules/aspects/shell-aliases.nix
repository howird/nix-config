{inputs, ...}: {
  # The `myShell` options themselves are declared in modules/defaults.nix, so
  # aspects other than this one can read them.
  den.aspects.shell-aliases.homeManager = {
    config,
    pkgs,
    isNixos,
    isDarwin,
    host ? null,
    ...
  }: {
    myShell.aliases = {
      uw-vpn = "sudo openconnect -v cn-vpn.uwaterloo.ca";
      tree = "eza --tree";
      cat = "bat";

      # Rebuild this flake the way this machine is actually managed.
      nixwird =
        if isNixos
        then "sudo nixos-rebuild switch --flake ${config.myShell.flakePath}"
        else if isDarwin
        then "sudo darwin-rebuild switch --flake ${config.myShell.flakePath}#${host.name}"
        else "home-manager switch --flake ${config.myShell.flakePath}${config.myShell.hmFlakeArgs}";
    };

    home.packages = with pkgs; [
      (writeShellScriptBin "nv-users" (builtins.readFile ./_shell-aliases/scripts/nv-users))
      (writeShellScriptBin "link2epub" (builtins.readFile ./_shell-aliases/scripts/link2epub))
    ];

    # Point legacy `<nixpkgs>` lookups (nix-shell, nix-instantiate, etc) at the
    # exact nixpkgs revision pinned in this flake's flake.lock, so they never
    # drift from what nixos-rebuild/home-manager actually build
    home.sessionVariables.NIX_PATH = "nixpkgs=${inputs.nixpkgs}:home-manager=${inputs.home-manager}";
  };
}
