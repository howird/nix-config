{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    extensions = with pkgs.vscode-extensions; [
      ms-python.python
      vscodevim.vim
      yzhang.markdown-all-in-one
      rust-lang.rust-analyzer
      mechatroner.rainbow-csv
      oderwat.indent-rainbow
      ms-azuretools.vscode-docker
      ms-vscode-remote.remote-ssh
      jnoortheen.nix-ide
      njpwerner.autodocstring
      eamodio.gitlens
      github.vscode-github-actions
      ms-azuretools.vscode-docker
      ms-vscode-remote.remote-containers
      github.copilot
      github.copilot-chat
      # James-Yu.latex-workshop
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
