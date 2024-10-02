{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.vscode.userSettings = {
    "update.mode" = "none";
    "extensions.autoUpdate" = true;
    "extensions.autoCheckUpdates" = true;
    "git.autofetch" = true;
    "editor.fontFamily" = "JetBrainsMono Nerd Font";
    "editor.fontLigatures" = true;
    "editor.lineNumbers" = "relative";
    "vim.smartRelativeLine" = true;
    "remote.autoForwardPortsSource" = "hybrid";
    "svelte.enable-ts-plugin" = true;
    "telemetry.enableTelemetry" = false;
    "redhat.telemetry.enabled" = false;
    "files.associations" = {"*.kbd" = "lisp";};
    "gitblame.inlineMessageEnabled" = true;
    "rust-analyzer.cargo.sysroot" = "${pkgs.rust-bin.stable.latest.default}/lib/rustlib/x86_64-unknown-linux-gnu/lib/";
  };
}
