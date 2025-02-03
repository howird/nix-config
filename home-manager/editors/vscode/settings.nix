{pkgs, ...}: {
  programs.vscode.userSettings = {
    "update.mode" = "none";
    "extensions.autoUpdate" = true;
    "extensions.autoCheckUpdates" = true;
    "git.autofetch" = true;
    "editor.fontLigatures" = true;
    "editor.lineNumbers" = "relative";
    "vim.smartRelativeLine" = true;
    "remote.autoForwardPortsSource" = "hybrid";
    "svelte.enable-ts-plugin" = true;
    "telemetry.telemetryLevel" = "off";
    "files.associations" = {"*.kbd" = "lisp";};
    "gitblame.inlineMessageEnabled" = true;
    "todo-tree.regex.regex" = "(//|#|<!--|;|/\\*|^|^[ \\t]*(-|\\d+.))\\s*($TAGS)|todo!";
    "rust-analyzer.cargo.sysroot" = "${pkgs.rust-bin.stable.latest.default}/lib/rustlib/x86_64-unknown-linux-gnu/lib/";

    "vim.leader" = "<space>";
    "vim.incSearch" = true;
    "vim.useCtrlKeys" = true;
    "vim.normalModeKeyBindings" = [
      {
        "before" = ["<leader>" "a"];
        "commands" = ["vscode-harpoon.addEditor"];
      }
      {
        "before" = ["<C-e>"];
        "commands" = ["vscode-harpoon.editEditors"];
      }
      {
        "before" = ["<leader>" "h"];
        "commands" = ["vscode-harpoon.gotoEditor1"];
      }
      {
        "before" = ["<leader>" "j"];
        "commands" = ["vscode-harpoon.gotoEditor2"];
      }
      {
        "before" = ["<leader>" "k"];
        "commands" = ["vscode-harpoon.gotoEditor3"];
      }
      {
        "before" = ["<leader>" "l"];
        "commands" = ["vscode-harpoon.gotoEditor4"];
      }
    ];
    "vim.handleKeys" = {
      "<C-p>" = false;
    };
    "vim.easymotion" = true;
    "vim.surround" = true;
    "vim.commentary" = true;
  };
  # programs.vscode.keybindings = ;
}
