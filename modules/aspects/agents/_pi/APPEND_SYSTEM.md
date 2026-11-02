## Nix-managed configuration

This machine's system and user configuration is managed declaratively in `~/nix/config`.

- Make configuration changes through the source files in that repository.
- Do not directly edit generated or deployed configuration under `~/.pi`, `~/.config`, `/etc`, or other Nix/Home Manager output paths.
- When the ownership of a configuration file is unclear, trace it back to its Nix module before editing it.
