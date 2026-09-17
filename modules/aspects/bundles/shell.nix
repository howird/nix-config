{den, ...}: {
  # Interactive shell environment: the shells themselves, their prompt,
  # multiplexer, aliases, and the terminal they run in.
  den.aspects.bundles.shell.includes = [
    den.aspects.zsh
    den.aspects.fish
    den.aspects.starship
    den.aspects.zellij
    den.aspects.shell-aliases
    den.aspects.ghostty
  ];
}
