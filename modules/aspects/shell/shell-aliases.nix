{inputs, ...}: {
  # The `myShell` options themselves are declared in modules/defaults.nix, so
  # aspects other than this one can read them.
  den.aspects.shell-aliases.homeManager = {
    config,
    lib,
    pkgs,
    isNixos,
    isDarwin,
    host ? null,
    ...
  }: let
    # Resolve the flake at invocation time, in either zsh or Nushell. Keep the
    # configured path as a fallback for sessions without Home Manager's env.
    nixwird = pkgs.writeShellScriptBin "nixwird" ''
      flake="''${NH_FLAKE:-${config.myShell.flakePath}}"
      ${
        if isNixos
        then ''exec sudo nixos-rebuild switch --flake "$flake" "$@"''
        else if isDarwin
        then ''exec sudo darwin-rebuild switch --flake "$flake#${host.name}" "$@"''
        else ''exec home-manager switch --flake "$flake${config.myShell.hmFlakeArgs}" "$@"''
      }
    '';
    # Reads the config's flake.lock from the working tree at run time, so it
    # follows `nix flake update` here without needing a rebuild.
    flake-sync = pkgs.writers.writeNuBin "flake-sync" (builtins.replaceStrings
      [''"~/nix/config"'']
      [''"${config.myShell.flakePath}"'']
      (builtins.readFile ./_shell-aliases/scripts/flake-sync.nu));
  in {
    myShell.aliases = {
      uw-vpn = "sudo openconnect -v cn-vpn.uwaterloo.ca";
      tree = "eza --tree";
      cat = "bat";

    };

    home.packages = with pkgs; [
      (writers.writeNuBin "nv-users" (builtins.readFile ./_shell-aliases/scripts/nv-users.nu))
      # percollate and pandoc come from the reading and typesetting aspects.
      (writers.writeNuBin "link2epub" (builtins.readFile ./_shell-aliases/scripts/link2epub.nu))
      flake-sync
      nixwird
    ];

    # direnv sources this before every .envrc, so each direnv repo warns when
    # its inputs drift from the config's, whatever its .envrc does. Only the
    # warning matters, so a mismatch must not abort the .envrc.
    programs.direnv.stdlib = ''
      ${lib.getExe flake-sync} check || true
    '';

    # Point legacy `<nixpkgs>` lookups (nix-shell, nix-instantiate, etc) at the
    # exact nixpkgs revision pinned in this flake's flake.lock, so they never
    # drift from what nixos-rebuild/home-manager actually build
    home.sessionVariables.NIX_PATH = "nixpkgs=${inputs.nixpkgs}:home-manager=${inputs.home-manager}";
  };
}
