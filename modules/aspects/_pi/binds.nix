{lib, ...}: let
  keybindings = {};
in {
  # pi.nix's module has no keybindings option
  home.file.".pi/agent/keybindings.json" = lib.mkIf (keybindings != {}) {
    text = builtins.toJSON keybindings;
  };
}
