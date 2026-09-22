{...}: {
  # Shell-agnostic wayland clipboard/capture primitives: `wl-copy`/`wl-paste`
  # for scripts, and grim+slurp behind niri's own Mod+S screenshot bind.
  # The clipboard *manager* is a shell concern - see den.aspects.cursor-clip
  # and noctalia's `[shell] clipboard_enabled`.
  den.aspects.clipboard.homeManager = {pkgs, ...}: {
    home.packages = with pkgs; [
      slurp
      grim
      wl-clipboard-rs
    ];
  };
}
