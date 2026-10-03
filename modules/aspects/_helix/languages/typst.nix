{pkgs, ...}: {
  # scroll tinymist preview to cursor: hover records the position,
  # scrollPreview with no args jumps there
  programs.helix.settings.keys.space.v = ["hover" ":lsp-workspace-command tinymist.scrollPreview"];

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
  };
}
