{...}: {
  # Screen-recording wrapper script. Shell-agnostic: noctalia only ships a
  # recorder as an opt-in plugin around gpu-screen-recorder, so this stays
  # regardless of which shell is running.
  den.aspects.record.homeManager = {pkgs, ...}: {
    home.packages = with pkgs; [
      zenity
      wf-recorder
      slurp
      wl-clipboard-rs
      (writeShellScriptBin "record" (builtins.readFile ./_record/record))
    ];
  };
}
