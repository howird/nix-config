{
  config,
  pkgs,
  ...
}: {
  xdg.configFile."zellij/layouts/task.kdl".text = ''
    layout {
        ${(import ./zjstatus.nix) {
      zjstatus_wasm = "file:${pkgs.zjstatus}/bin/zjstatus.wasm";
      colors = config.lib.stylix.colors;
      format_left = "{mode}";
    }}
        pane command="taskwarrior-tui"
        pane size="30%"
    }
  '';
}
