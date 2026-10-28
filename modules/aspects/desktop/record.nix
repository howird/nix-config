{
  # Screen-recording wrapper script. Shell-agnostic: noctalia only ships a
  # recorder as an opt-in plugin around gpu-screen-recorder, so this stays
  # regardless of which shell is running.
  den.aspects.record.homeManager = {
    pkgs,
    lib,
    ...
  }: {
    home.packages = [
      (pkgs.writers.writeNuBin "record" {
          makeWrapperArgs = [
            "--prefix"
            "PATH"
            ":"
            (lib.makeBinPath (with pkgs; [
              coreutils
              ffmpeg
              gifsicle
              libnotify
              slurp
              wf-recorder
              wl-clipboard-rs
              zenity
            ]))
          ];
        }
        (builtins.readFile ./_record/record.nu))
    ];
  };
}
