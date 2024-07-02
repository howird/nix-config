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
      package =
        if config.myEditor.vscode
        then pkgs.vscode-fhs
        else pkgs.vscodium-fhs;
      extensions = with pkgs.vscode-extensions;
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
          tomoki1207.pdf
          yzhang.markdown-all-in-one
          tamasfe.even-better-toml
          redhat.vscode-yaml
          ms-python.python
          jnoortheen.nix-ide
          rust-lang.rust-analyzer
          serayuzgur.crates
          svelte.svelte-vscode
          bradlc.vscode-tailwindcss
          dbaeumer.vscode-eslint

          # James-Yu.latex-workshop
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [];
      userSettings = {
        "git.autofetch" = true;
        "editor.fontFamily" = "JetBrainsMono Nerd Font";
        "editor.fontLigatures" = true;
        "editor.lineNumbers" = "relative";
        "vim.smartRelativeLine" = true;
        "remote.autoForwardPortsSource" = "hybrid";
        "svelte.enable-ts-plugin" = true;
      };
    };
  };
}
