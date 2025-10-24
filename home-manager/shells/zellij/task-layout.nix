{
  config,
  pkgs,
  ...
}: {
  xdg.configFile."zellij/layouts/task.kdl".text = let
    zjstatus = (import ./zjstatus.nix) {
      zjstatus_wasm = "file:${pkgs.zjstatus}/bin/zjstatus.wasm";
      colors = config.lib.stylix.colors;
      format_left = "{mode}";
    };
  in ''
    layout {
        ${zjstatus}
        pane command="taskwarrior-tui"
        pane size="30%"
    }
  '';
}
