{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  config = {
    programs.vscode = lib.mkIf (config.myEditor.vscode || config.myEditor.vscodium) {
      enable = true;
      package = if config.myEditor.vscode then pkgs.vscode-fhs else pkgs.vscodium-fhs;
      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
        ms-vscode-remote.remote-containers
        ms-vscode-remote.remote-ssh
        ms-azuretools.vscode-docker
        github.vscode-github-actions
        mkhl.direnv
        mhutchie.git-graph
        waderyan.gitblame

        github.copilot
        github.copilot-chat

        jnoortheen.nix-ide
        ms-python.python
        yzhang.markdown-all-in-one
        rust-lang.rust-analyzer
        svelte.svelte-vscode
        # James-Yu.latex-workshop

        mechatroner.rainbow-csv
        oderwat.indent-rainbow
        njpwerner.autodocstring
      ];
      userSettings = {
        "git.autofetch" = true;
        "editor.fontFamily" = "JetBrainsMono Nerd Font";
        "editor.fontLigatures" = true;
        "editor.lineNumbers" = "relative";
        "vim.smartRelativeLine" = true;
        "remote.autoForwardPortsSource" = "hybrid";
      };
    };
  };
}
