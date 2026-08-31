{pkgs, ...}: {
  programs.helix.languages = {
    language = [
      {
        name = "typst";
        auto-format = true;
        language-servers = ["tinymist" "harper-ls"];
        formatter.command = "${pkgs.typstyle}/bin/typstyle";
      }
    ];

    language-server.tinymist = {
      command = "tinymist";
      config = {
        preview.background = {
          enabled = true;
          args = ["--data-plane-host=127.0.0.1:23635" "--invert-colors=never" "--open"];
        };
      };
    };

    language-server.texlab = {
      command = "texlab";
      config = {
        auxDirectory = "output";
        chktex = {
          onOpenAndSave = true;
          onEdit = true;
        };
        build = {
          forwardSearchAfter = false;
          onSave = false;
          executable = "tectonic";
          args = [
            "-X"
            "compile"
            "%f"
            "--synctex"
            "--keep-logs"
            "--keep-intermediates"
            "--outdir=output"
            "-Zshell-escape"
          ];
        };
        forwardSearch = {
          executable = "sioyek";
          args = [
            # "--reuse-window"
            # "--forward-search-file"
            # "%f"
            # "--forward-search-line"
            # "%l"
            # "%p"
            "--reuse-window"
            "--execute-command"
            "toggle_synctex"
            "--inverse-search"
            ''texlab inverse-search -i "%%1" -l %%2''
            "--forward-search-file"
            "%f"
            "--forward-search-line"
            "%l"
            "%p"
          ];
        };
      };
    };
  };

  home.packages = with pkgs; [
    texlab
    tectonic
  ];
}
