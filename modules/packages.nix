{inputs, ...}: {
  # This overlay brings our custom packages (thin aliases onto other flakes'
  # own packages) into `pkgs.*`, so nixos/home-manager modules can reference
  # them normally (e.g. `pkgs.ghostty`).
  flake.overlays.default = final: _prev: let
    inherit (final.stdenv.hostPlatform) system;
  in {
    ghostty = inputs.ghostty.packages.${system}.default;
    zen-browser = inputs.zen-browser.packages.${system}.twilight;
    zsh-helix-mode = inputs.zsh-helix-mode.packages.${system}.default;
    zesh = inputs.zesh.packages.${system}.default;
  };

  perSystem = {...}: {
    packages = let
      system = "x86_64-linux";
    in {
      ghostty = inputs.ghostty.packages.${system}.default;
      zen-browser = inputs.zen-browser.packages.${system}.twilight;
      zsh-helix-mode = inputs.zsh-helix-mode.packages.${system}.default;
      zesh = inputs.zesh.packages.${system}.default;
    };
  };
}
