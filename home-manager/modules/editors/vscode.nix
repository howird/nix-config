{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.vscode = {
    package = pkgs.vscode;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      ms-vscode-remote.remote-containers
      ms-vscode-remote.remote-ssh
      ms-azuretools.vscode-docker
      github.vscode-github-actions
      eamodio.gitlens

      github.copilot
      github.copilot-chat

      jnoortheen.nix-ide
      ms-python.python
      yzhang.markdown-all-in-one
      rust-lang.rust-analyzer
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
}
