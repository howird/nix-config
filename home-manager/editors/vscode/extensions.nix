{pkgs, ...}: {
  programs.vscode.profiles.default.extensions = with pkgs.vscode-extensions;
    [
      # essentials
      ms-vscode-remote.remote-containers
      ms-vscode-remote.remote-ssh
      ms-azuretools.vscode-docker
      # vscodevim.vim
      mkhl.direnv

      # git
      mhutchie.git-graph
      waderyan.gitblame
      donjayamanne.githistory

      # look nice
      oderwat.indent-rainbow
      gruntfuggly.todo-tree
      usernamehw.errorlens
      naumovs.color-highlight

      # python
      ms-python.python
      ms-python.debugpy
      ms-toolsai.jupyter
      ms-toolsai.jupyter-renderers
      njpwerner.autodocstring

      # text
      myriad-dreamin.tinymist
      james-yu.latex-workshop
      vitaliymaz.vscode-svg-previewer
      tomoki1207.pdf
      yzhang.markdown-all-in-one

      # rust & c/c++
      fill-labs.dependi
      rust-lang.rust-analyzer
      vadimcn.vscode-lldb
      ms-vscode.cpptools
      ms-vscode.cmake-tools

      # web
      svelte.svelte-vscode
      bradlc.vscode-tailwindcss
      dbaeumer.vscode-eslint
      ms-vscode.live-server

      # misc langs
      tamasfe.even-better-toml
      redhat.vscode-yaml
      mechatroner.rainbow-csv
      jnoortheen.nix-ide
      mattn.lisp

      # misc tools
      github.vscode-github-actions
      # streetsidesoftware.code-spell-checker
      wmaurer.change-case

      # AI
      github.copilot
      anthropic.claude-code
      saoudrizwan.claude-dev
    ]
    ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "vscode-helix-emulation";
        publisher = "jasew";
        version = "0.7.0";
        sha256 = "sha256-gYyIVnXG9Atmik0c1FsRKO2idFnufwl26nOiH3DYPLY=";
      }
    ];
}
