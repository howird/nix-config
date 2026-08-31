{...}: {
  programs.vscode.profiles.default.userSettings = {
    "update.mode" = "none";
    "extensions.autoUpdate" = true;
    "extensions.autoCheckUpdates" = true;
    "git.autofetch" = true;
    "editor.fontLigatures" = true;
    "editor.lineNumbers" = "relative";
    "remote.autoForwardPortsSource" = "hybrid";
    "svelte.enable-ts-plugin" = true;
    "telemetry.telemetryLevel" = "off";
    "files.associations" = {"*.kbd" = "lisp";};
    "gitblame.inlineMessageEnabled" = true;
    "todo-tree.regex.regex" = "(//|#|<!--|;|/\\*|^|^[ \\t]*(-|\\d+.))\\s*($TAGS)|todo!";
    "helixKeymap.toggleRelativeLineNumbers" = true;
  };
}
