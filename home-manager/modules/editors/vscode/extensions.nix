{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.vscode.extensions = with pkgs.vscode-extensions;
    [
      vscodevim.vim
      ms-vscode-remote.remote-containers
      ms-vscode-remote.remote-ssh
      ms-azuretools.vscode-docker
      github.vscode-github-actions
      vadimcn.vscode-lldb
      mkhl.direnv
      mhutchie.git-graph
      waderyan.gitblame
      streetsidesoftware.code-spell-checker
      # wayou.vscode-todo-highlight
      wmaurer.change-case

      github.copilot
      github.copilot-chat

      mechatroner.rainbow-csv
      oderwat.indent-rainbow
      njpwerner.autodocstring

      # vitaliymaz.vscode-svg-previewer
      ms-toolsai.jupyter
      tomoki1207.pdf
      yzhang.markdown-all-in-one
      tamasfe.even-better-toml
      redhat.vscode-yaml
      ms-python.python
      ms-python.debugpy
      jnoortheen.nix-ide
      rust-lang.rust-analyzer
      serayuzgur.crates
      svelte.svelte-vscode
      bradlc.vscode-tailwindcss
      dbaeumer.vscode-eslint
      mattn.lisp

      # James-Yu.latex-workshop
    ]
    ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [];
}
